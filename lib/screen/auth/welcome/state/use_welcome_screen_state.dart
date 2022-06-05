import 'package:ekorek/screen/auth/sign_in/sign_in_screen.dart';
import 'package:ekorek/screen/auth/sign_up/sign_up_screen.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class WelcomeScreenState {
  final void Function() onSignIn;
  final void Function() onSignUp;


  WelcomeScreenState({
    required this.onSignIn,
    required this.onSignUp,
  });
}

WelcomeScreenState useWelcomeScreenState() {
  final context = useContext();

  return WelcomeScreenState(
    onSignIn: () async => await context.navigator.pushNamed(SignInScreen.route),
    onSignUp: () async => await context.navigator.pushNamed(SignUpScreen.route),
  );
}
