import 'package:ekorek/app/state/user/user_state.dart';
import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:ekorek/service/appointment_service/appointments_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AppointmentsState {
  final IList<Appointment> appointments;

  const AppointmentsState({
    required this.appointments,
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
    );
  }
}
