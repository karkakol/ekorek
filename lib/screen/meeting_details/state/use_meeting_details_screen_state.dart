import 'package:ekorek/app/state/user/user_state.dart';
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
  final bool isLoading;
  final void Function() onCancelAppointment;
  final User? user;

  MeetingDetailsState({
    required this.appointment,
    required this.isLoading,
    required this.onCancelAppointment,
    required this.user,
  });
}

MeetingDetailsState useMeetingDetailsState({required MeetingsDetailsScreenArgs args}) {
  final currentUser = useProvided<UserState>().user!;
  final appointment = args.appointment;
  final appointmentService = useInjected<AppointmentsService>();
  final userService = useInjected<UserService>();
  final userState = useState<User?>(null);
  final context = useContext();

  useMemoized(() async {
    userState.value = await userService.getUser(currentUser == appointment.studentId ? appointment.tutorId : appointment.studentId);
  });

  return MeetingDetailsState(
    appointment: appointment,
    isLoading: userState.value == null,
    onCancelAppointment: () async {
      await appointmentService.cancel(appointment);
      context.navigator.pop();
    },
    user: userState.value,
  );
}
