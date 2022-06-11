import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'state/use_meetings_page_state.dart';
import 'view/meetings_page_view.dart';


class MeetingsPage extends HookWidget {
  const MeetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useMeetingsPageState();
    return MeetingsPageView(state: state);
  }
}
