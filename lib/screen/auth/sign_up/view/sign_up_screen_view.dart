import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:ekorek/screen/auth/sign_up/state/use_sign_up_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class SignUpScreenView extends StatelessWidget {
  final SignUpScreenState state;

  const SignUpScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextInput(
                fieldState: state.emailFieldState,
                label: "Email",
              ),
              TextInput(
                fieldState: state.passwordFieldState,
                label: "Password",
              ),
              SizedBox(height: 8),
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
            ].separatedWith(SizedBox(height: 8)),
          ),
        ),
      ),
    );
  }
}
