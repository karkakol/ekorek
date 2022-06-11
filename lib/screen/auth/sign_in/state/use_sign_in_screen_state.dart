import 'package:ekorek/app/state/appointments/appointments_state.dart';
import 'package:ekorek/app/state/user/user_state.dart';
import 'package:ekorek/screen/auth/sign_up/sign_up_screen.dart';
import 'package:ekorek/screen/home/home_screen.dart';
import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

import '../../../../app/state/users/users_state.dart';

class SignInScreenState {
  final FieldState emailFieldState;
  final FieldState passwordFieldState;
  final SubmitState submitState;
  final bool isSubmitEnabled;
  final String? submitError;
  final void Function() onSignIn;
  final void Function() onSignUp;


  SignInScreenState({
    required this.emailFieldState,
    required this.passwordFieldState,
    required this.submitState,
    required this.isSubmitEnabled,
    required this.submitError,
    required this.onSignIn,
    required this.onSignUp,
  });
}

SignInScreenState useSignInScreenState() {
  final authService = useInjected<AuthService>();
  final usersState = useProvided<UsersState>();
  final userState = useProvided<UserState>();
  final appointmentsState = useProvided<AppointmentsState>();

  final emailFieldState = useFieldState();
  final passwordFieldState = useFieldState();
  final errorState = useState<String?>(null);
  final context = useContext();

  final submitState = useSubmitState();

  Future<void> onSignIn() async {
    await submitState.runSimple<void, FirebaseAuthException>(
      beforeSubmit: () => errorState.value = null,
      shouldSubmit: () => true,
      submit: () async {
        await authService.signIn(email: emailFieldState.value, password: passwordFieldState.value);
        await usersState.getTutors();
        final user = await userState.refreshUser();
        await appointmentsState.getAppointments(user!);
      },
      mapError: (error) => error is FirebaseAuthException ? error : null,
      afterKnownError: (error) => errorState.value = error.message,
      afterSubmit: (_) => context.navigator.pushNamedAndRemoveUntil(HomeScreen.route, (_) => false),
    );
  }

  Future<void> navigateToSignUp() async {
    await context.navigator.pushReplacementNamed(SignUpScreen.route);
  }

  return SignInScreenState(
    emailFieldState: emailFieldState,
    passwordFieldState: passwordFieldState,
    submitState: submitState,
    isSubmitEnabled: passwordFieldState.value.isNotEmpty && emailFieldState.value.isNotEmpty,
    submitError: errorState.value,
    onSignIn: onSignIn,
    onSignUp: navigateToSignUp,
  );
}
