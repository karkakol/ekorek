import 'package:ekorek/common/widgets/button/button.dart';
import 'package:ekorek/common/widgets/dropdown/dropdown.dart';
import 'package:ekorek/common/widgets/subjects_picker/subjects_input.dart';
import 'package:ekorek/common/widgets/text_input/text_input.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/user/user_type.dart';
import 'package:ekorek/screen/auth/sign_up/state/use_sign_up_screen_state.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';
import 'package:utopia_widgets/layout/form_layout.dart';

class SignUpScreenView extends StatelessWidget {
  final SignUpScreenState state;

  const SignUpScreenView({Key? key, required this.state}) : super(key: key);

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
        bottom: _buildSubmitButton(),
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
            "Create your Account",
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
          TextInput(
            fieldState: state.firstNameFieldState,
            label: "First Name",
          ),
          TextInput(
            fieldState: state.lastNameFieldState,
            label: "Last Name",
          ),
          TextInput(
            fieldState: state.cityFieldState,
            label: "City",
          ),
          TextInput(
            fieldState: state.postalCodeFieldState,
            label: "Postal Code",
          ),
          TextInput(
            fieldState: state.streetFieldState,
            label: "Street",
          ),
          TextInput(
            fieldState: state.numberFieldState,
            label: "House Number",
          ),
          Dropdown<UserType>(
            state: state.userTypeState,
            label: "Account Type",
            itemBuilder: (value) => Text(value.name),
          ),
          if (state.userTypeState.value == UserType.TUTOR)
            SubjectsInput(
              subjects: state.subjects,
              onChanged: state.onSubjectsChanged,
            ),
        ].separatedWith(SizedBox(height: 8)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
    );
  }

  Widget _buildSignInSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Already have an account?"),
        SizedBox(width: 16),
        Button(
          onTap: state.onSignIn,
          text: "Sign In",
          expanded: false,
        ),
      ],
    );
  }
}
