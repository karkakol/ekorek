import 'package:ekorek/common/widgets/button/button.dart';
import 'package:flutter/material.dart';

import '../state/use_welcome_screen_state.dart';

class WelcomeScreenView extends StatelessWidget {
  final WelcomeScreenState state;

  const WelcomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(onTap: state.onSignIn, text: "Sign In"),
            SizedBox(width: 16),
            Button(onTap: state.onSignUp, text: "Sign Up"),
          ],
        ),
      ),
    );
  }
}
