import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../state/use_welcome_screen_state.dart';

class WelcomeScreenView extends StatelessWidget {
  final WelcomeScreenState state;

  const WelcomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor,
            AppColors.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColors.darkColor),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.5),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 150,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildForm(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Let's you in",
                style: context.themeData.textTheme.headline5,
                textAlign: TextAlign.left,
              ),
            ),
            Button(onTap: state.onSignIn, text: "Sign In"),
            SizedBox(width: 16),
            Button(onTap: state.onSignUp, text: "Create Account"),
          ],
        ),
      ),
    );
  }
}
