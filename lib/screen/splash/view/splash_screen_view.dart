import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/screen/splash/state/use_splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenView extends StatelessWidget {
  final SplashScreenState state;

  const SplashScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor,
            AppColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SpinKitCircle(
        size: 80,
        color: Colors.white,
      ),
    );
  }
}
