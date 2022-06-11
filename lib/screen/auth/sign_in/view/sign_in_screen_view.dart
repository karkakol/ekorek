import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/config/app_text.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';
import 'package:utopia_widgets/layout/form_layout.dart';
import '../state/use_sign_in_screen_state.dart';

class SignInScreenView extends StatelessWidget {
  final SignInScreenState state;

  const SignInScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.darkColor),
      ),
      body: FormLayout.simple(
        backgroundColor: Colors.white,
        fadeBarHeight: 32,
        content: _buildForm(context),
        bottom: SizedBox.shrink(),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Login to your Account",
            style: context.themeData.textTheme.headline5,
            textAlign: TextAlign.left,
          ),
          TextInput(
            fieldState: state.emailFieldState,
            label: "Email",
          ),
          TextInput(
            fieldState: state.passwordFieldState,
            label: "Password",
          ),
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
    );
  }

  Widget _buildSignUpSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Don't have an account?",
          style: AppText.body,
        ),
        SizedBox(height: 8),
        Button(
          onTap: state.onSignUp,
          text: "Create account",
        ),
      ],
    );
  }
}
