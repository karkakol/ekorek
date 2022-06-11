import 'package:ekorek/app/state/appointments/appointments_state.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class MeetingsPageState {
  final IList<Appointment> incomingAppointments;
  final IList<Appointment> currentAppointments;
  final IList<Appointment> historyAppointments;

  MeetingsPageState({
    required this.incomingAppointments,
    required this.currentAppointments,
    required this.historyAppointments,
  });
}

MeetingsPageState useMeetingsPageState() {
  final appointmentsState = useProvided<AppointmentsState>();

  final time = DateTime.now().toUtc().millisecondsSinceEpoch;

  isNow(Appointment appointment) {
    return appointment.startTime.millisecondsSinceEpoch < time && appointment.endTime.millisecondsSinceEpoch > time;
  }

  isFuture(Appointment appointment) {
    return appointment.startTime.millisecondsSinceEpoch > time;
  }

  isPast(Appointment appointment) {
    return appointment.endTime.millisecondsSinceEpoch < time;
  }

  return MeetingsPageState(
    incomingAppointments: appointmentsState.appointments.where((e) => isFuture(e)).toIList(),
    currentAppointments: appointmentsState.appointments.where((e) => isNow(e)).toIList(),
    historyAppointments: appointmentsState.appointments.where((e) => isPast(e)).toIList(),
  );
}
