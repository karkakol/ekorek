import 'package:ekorek/screen/meeting_details/meetings_details_screen_args.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'state/use_meeting_details_screen_state.dart';
import 'view/meeting_details_screen_view.dart';

class MeetingDetailsScreen extends HookWidget {
  static const route = '/meetingDetails';
  static final routeConfig = RouteConfig.material(() => const MeetingDetailsScreen());

  const MeetingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MeetingsDetailsScreenArgs;
    final state = useMeetingDetailsState(args: args);
    return MeetingDetailsView(state: state);
  }
}
