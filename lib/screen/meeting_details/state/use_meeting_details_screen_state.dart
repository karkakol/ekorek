import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/appointment/appointment.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/screen/meeting_details/meetings_details_screen_args.dart';
import 'package:ekorek/service/appointment_service/appointments_service.dart';
import 'package:ekorek/service/user_service/user_service.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class MeetingDetailsState {
  final Appointment appointment;
  final User? student;
  final User? tutor;
  final bool isLoading;
  final void Function() onCancelAppointment;

  MeetingDetailsState({
    required this.appointment,
    required this.tutor,
    required this.student,
    required this.isLoading,
    required this.onCancelAppointment,
  });
}

MeetingDetailsState useMeetingDetailsState({required MeetingsDetailsScreenArgs args}) {
  final appointment = args.appointment;
  final appointmentService = useInjected<AppointmentsService>();
  final userService = useInjected<UserService>();
  final studentState = useState<User?>(null);
  final tutorState = useState<User?>(null);
  final context = useContext();

  useMemoized(() async {
    studentState.value = await userService.getUser(appointment.studentId);
    tutorState.value = await userService.getUser(appointment.tutorId);
  });


  return MeetingDetailsState(
    student: studentState.value,
    tutor: tutorState.value,
    appointment: appointment,
    isLoading: studentState.value == null || tutorState.value == null,
    onCancelAppointment: () async {
      await appointmentService.cancel(appointment);
      context.navigator.pop();
    }
  );
}
