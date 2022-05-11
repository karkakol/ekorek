import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:ekorek/screen/auth/sign_up/state/use_sign_up_screen_state.dart';
import 'package:flutter/material.dart';

class SignUpScreenView extends StatelessWidget {
  final SignUpScreenState state;

  const SignUpScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Sign up"),
              TextInput(
                fieldState: state.emailFieldState,
                label: "Email",
              ),
              TextInput(
                fieldState: state.passwordFieldState,
                label: "Password",
              ),
              Button(
                onTap: state.onSignUp,
                text: "Sign up",
                isLoading: state.submitState.isSubmitInProgress,
                enabled: state.isSubmitEnabled,
              ),
              if (state.submitError != null)
                Text(
                  state.submitError!,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
