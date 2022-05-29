import 'package:ekorek/di/injector.dart';
import 'package:ekorek/screen/auth/sign_in/sign_in_screen.dart';
import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class HomeScreenState {
  final SubmitState submitState;
  final void Function() onSignOut;

  HomeScreenState({
    required this.submitState,
    required this.onSignOut,
  });
}

HomeScreenState useHomeScreenState() {
  final authService = useInjected<AuthService>();
  final errorState = useState<String?>(null);
  final context = useContext();

  final submitState = useSubmitState();

  Future<void> onSignOut() async {
    await submitState.runSimple<void, FirebaseAuthException>(
      beforeSubmit: () => errorState.value = null,
      shouldSubmit: () => true,
      submit: () async => await authService.signOut(),
      mapError: (error) => error is FirebaseAuthException ? error : null,
      afterKnownError: (error) => errorState.value = error.message,
      afterSubmit: (_) async{
        await context.navigator.pushNamedAndRemoveUntil(SignInScreen.route, (_) => false);
      }
    );
  }
  return HomeScreenState(
    onSignOut: onSignOut,
    submitState: submitState,
  );
}
