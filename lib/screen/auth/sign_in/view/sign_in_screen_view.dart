import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';
import '../state/use_sign_in_screen_state.dart';

class SignInScreenView extends StatelessWidget {
  final SignInScreenState state;

  const SignInScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
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
                onTap: state.onSignIn,
                text: "Sign in",
                isLoading: state.submitState.isSubmitInProgress,
                enabled: state.isSubmitEnabled,
              ),
              if (state.submitError != null)
                Text(
                  state.submitError!,
                  style: TextStyle(color: Colors.red),
                ),
              Divider(height: 16, thickness: 1),
              _buildSignUpSection(),
            ].separatedWith(SizedBox(height: 8)),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Don't have an account?"),
        SizedBox(height: 8),
        Button(
          onTap: state.onSignUp,
          text: "Create account",
        ),
      ],
    );
  }
}
