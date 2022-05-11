import 'package:ekorek/screen/splash/state/use_splash_screen_state.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  final SplashScreenState state;

  const SplashScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Ekorek"),
      ),
    );
  }
}
