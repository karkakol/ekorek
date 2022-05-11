import 'package:ekorek/screen/splash/state/use_splash_screen_state.dart';
import 'package:ekorek/screen/splash/view/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SplashScreen extends HookWidget {
  static const route = '/splash';
  static final routeConfig = RouteConfig.material(() => const SplashScreen());

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useSplashScreenState();
    return SplashScreenView(state: state);
  }
}
