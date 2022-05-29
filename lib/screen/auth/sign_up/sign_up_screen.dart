import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'state/use_sign_up_screen_state.dart';
import 'view/sign_up_screen_view.dart';

class SignUpScreen extends HookWidget {
  static const route = '/signUp';
  static final routeConfig = RouteConfig.material(() => const SignUpScreen());

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useSignUpScreenState();
    return SignUpScreenView(state: state);
  }
}
