import 'package:ekorek/screen/create_appointment/state/create_appointemtn_screen_args.dart';
import 'package:ekorek/screen/meeting_details/meetings_details_screen.dart';
import 'package:ekorek/screen/meeting_details/meetings_details_screen_args.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

import './state/create_appointment_screen_state.dart';
import './view/create_appointment_screen_view.dart';

class CreateAppointmentScreen extends HookWidget {
  static const route = '/createAppointment';
  static final routeConfig = RouteConfig.material(() => const CreateAppointmentScreen());

  const CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = context.navigator;

    final args = ModalRoute.of(context)!.settings.arguments as CreateAppointmentScreenArgs;


    final state = useCreateAppointmentScreenState(
      args: args,
      navigateToDetailedMeeting: (appointment)=> navigator.pushReplacementNamed(MeetingDetailsScreen.route, arguments: MeetingsDetailsScreenArgs(appointment: appointment)),
    );

    return CreateAppointmentScreenView(state: state);
  }
}
