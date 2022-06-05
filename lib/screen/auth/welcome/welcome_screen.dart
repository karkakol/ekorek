import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'state/use_welcome_screen_state.dart';
import 'view/welcome_screen_view.dart';

class WelcomeScreen extends HookWidget {
  static const route = '/welcome';
  static final routeConfig = RouteConfig.material(() => const WelcomeScreen());

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useWelcomeScreenState();
    return WelcomeScreenView(state: state);
  }
}
