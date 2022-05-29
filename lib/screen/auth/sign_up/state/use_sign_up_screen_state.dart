import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SignUpScreenState {
  final FieldState emailFieldState;
  final FieldState passwordFieldState;
  final SubmitState submitState;
  final bool isSubmitEnabled;
  final String? submitError;
  final void Function() onSignUp;

  SignUpScreenState({
    required this.emailFieldState,
    required this.passwordFieldState,
    required this.submitState,
    required this.isSubmitEnabled,
    required this.submitError,
    required this.onSignUp,
  });
}

SignUpScreenState useSignUpScreenState() {
  final authService = useInjected<AuthService>();
  final emailFieldState = useFieldState();
  final passwordFieldState = useFieldState();
  final errorState = useState<String?>(null);

  final submitState = useSubmitState();

  Future<void> onSignUp() async {
    await submitState.runSimple<void, FirebaseAuthException>(
      beforeSubmit: () => errorState.value = null,
      shouldSubmit: () => true,
      submit: () async => await authService.signUp(email: emailFieldState.value, password: passwordFieldState.value),
      mapError: (error) => error is FirebaseAuthException ? error : null,
      afterKnownError: (error) => errorState.value = error.message,
      afterSubmit: (_) => errorState.value = "Signed Up :)!",
    );
  }

  return SignUpScreenState(
    emailFieldState: emailFieldState,
    passwordFieldState: passwordFieldState,
    onSignUp: onSignUp,
    submitState: submitState,
    isSubmitEnabled: passwordFieldState.value.isNotEmpty && emailFieldState.value.isNotEmpty,
    submitError: errorState.value,
  );
}
