import 'package:ekorek/app/state/auth/auth_state.dart';
import 'package:ekorek/app/state/setup/use_async_after_setup.dart';
import 'package:ekorek/screen/auth/sign_in/sign_in_screen.dart';
import 'package:ekorek/screen/home/home_screen.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class SplashScreenState {
  SplashScreenState();
}

SplashScreenState useSplashScreenState() {
  final context = useContext();
  final authState = useProvided<AuthState>();

  Future<void> navigateToHome() async {
    await context.navigator.pushNamedAndRemoveUntil(HomeScreen.route, (_) => false);
  }

  Future<void> navigateToSignIn() async {
    await context.navigator.pushNamedAndRemoveUntil(SignInScreen.route, (_) => false);
  }

  useAsyncEffectAfterSetup(() async {
    if (authState.user != null)
      navigateToHome();
    else
      navigateToSignIn();
  });
  return SplashScreenState();
}
