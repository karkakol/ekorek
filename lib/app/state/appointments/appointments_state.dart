import 'package:ekorek/app/state/user/user_state.dart';
import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/model/user/user_type.dart';
import 'package:ekorek/service/appointment_service/appointments_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AppointmentsState {
  final IList<Appointment> appointments;
  final Function(User) getAppointments;

  const AppointmentsState({
    required this.appointments,
    required this.getAppointments,
  });
}

class AppointmentsStateProvider extends HookStateProviderWidget<AppointmentsState> {
  const AppointmentsStateProvider({Key? key}) : super(key: key);

  @override
  AppointmentsState use() {
    final appointmentsService = useInjected<AppointmentsService>();
    final appointmentsState = useState<IList<Appointment>>(IList());
    final userState = useProvided<UserState>();
    final user = userState.user;

    final appointmentsStream = useStream(appointmentsService.allAppointmentsStream());

    useSimpleEffect(() async {
      if (appointmentsStream.data != null) appointmentsState.value = appointmentsStream.data!;
    }, [appointmentsStream.data]);

    return AppointmentsState(
      appointments: user != null ? appointmentsState.value.where((e) => e.studentId == user.id || e.tutorId == user.id).toIList() : IList(),
      getAppointments: (user) async {
        Logger().i("Appointmens for $user");
        appointmentsState.value = user.type == UserType.STUDENT
            ? await appointmentsService.getStudentAppointments(user.id)
            : await appointmentsService.getTutorAppointments(user.id);
      },
    );
  }
}
