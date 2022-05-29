import 'package:ekorek/app/state/auth/auth_state.dart';
import 'package:ekorek/app/state/setup/use_async_after_setup.dart';
import 'package:ekorek/screen/auth/welcome/welcome_screen.dart';
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

  Future<void> navigateToWelcome() async {
    await context.navigator.pushNamedAndRemoveUntil(WelcomeScreen.route, (_) => false);
  }

  useAsyncEffectAfterSetup(() async {
    if (authState.user != null)
      navigateToHome();
    else
      navigateToWelcome();
  });

  return SplashScreenState();
}
