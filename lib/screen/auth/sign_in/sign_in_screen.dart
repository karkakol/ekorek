import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import 'state/use_sign_in_screen_state.dart';
import 'view/sign_in_screen_view.dart';

class SignInScreen extends HookWidget {
  static const route = '/sign_in';
  static final routeConfig = RouteConfig.material(() => const SignInScreen());

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useSignInScreenState();
    return SignInScreenView(state: state);
  }
}
