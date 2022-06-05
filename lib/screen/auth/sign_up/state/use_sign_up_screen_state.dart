import 'package:ekorek/common/widgets/dropdown/use_dropdown_state.dart';
import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/model/user/user_type.dart';
import 'package:ekorek/screen/auth/sign_in/sign_in_screen.dart';
import 'package:ekorek/screen/home/home_screen.dart';
import 'package:ekorek/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

import '../../../../app/state/users/users_state.dart';

class SignUpScreenState {
  final FieldState emailFieldState;
  final FieldState passwordFieldState;
  final FieldState firstNameFieldState;
  final FieldState lastNameFieldState;
  final FieldState cityFieldState;
  final FieldState postalCodeFieldState;
  final FieldState streetFieldState;
  final FieldState numberFieldState;

  final DropdownState<UserType> userTypeState;
  final SubmitState submitState;
  final bool isSubmitEnabled;
  final String? submitError;
  final void Function() onSignUp;
  final void Function() onSignIn;

  SignUpScreenState({
    required this.emailFieldState,
    required this.passwordFieldState,
    required this.firstNameFieldState,
    required this.lastNameFieldState,
    required this.userTypeState,
    required this.onSignIn,
    required this.submitState,
    required this.isSubmitEnabled,
    required this.submitError,
    required this.onSignUp,
    required this.cityFieldState,
    required this.postalCodeFieldState,
    required this.streetFieldState,
    required this.numberFieldState,
  });
}

SignUpScreenState useSignUpScreenState() {
  final authService = useInjected<AuthService>();
  final usersState = useProvided<UsersState>();

  final emailFieldState = useFieldState();
  final passwordFieldState = useFieldState();
  final firstNameFieldState = useFieldState();
  final lastNameFieldState = useFieldState();
  final cityFieldState = useFieldState();
  final postalCodeFieldState = useFieldState();
  final streetFieldState = useFieldState();
  final numberFieldState = useFieldState();
  final userTypeState = useDropdownState<UserType>(initialValue: UserType.STUDENT, items: UserType.values);

  final errorState = useState<String?>(null);
  final context = useContext();

  final submitState = useSubmitState();

  final isSubmitEnabled = ![
    passwordFieldState.value.isNotEmpty,
    emailFieldState.value.isNotEmpty,
    firstNameFieldState.value.isNotEmpty,
    lastNameFieldState.value.isNotEmpty,
  ].contains(false);

  buildStudent() {
    return model.UserStudent(
      email: emailFieldState.value,
      firstName: firstNameFieldState.value,
      lastName: lastNameFieldState.value,
      city: cityFieldState.value,
      postalCode: postalCodeFieldState.value,
      street: streetFieldState.value,
      number: numberFieldState.value,
    );
  }

  buildTutor() {
    return model.UserTutor(
      email: emailFieldState.value,
      firstName: firstNameFieldState.value,
      lastName: lastNameFieldState.value,
      city: cityFieldState.value,
      postalCode: postalCodeFieldState.value,
      street: streetFieldState.value,
      number: numberFieldState.value,
      subjects: [],
    );
  }

  Future<void> onSignUp() async {
    await submitState.runSimple<void, FirebaseAuthException>(
      beforeSubmit: () => errorState.value = null,
      shouldSubmit: () => true,
      submit: () async {
        await authService.signUp(
        email: emailFieldState.value,
        password: passwordFieldState.value,
        user: userTypeState.value == UserType.TUTOR ? buildTutor() : buildStudent()
      );
        await usersState.getTutors();
        },
      mapError: (error) => error is FirebaseAuthException ? error : null,
      afterKnownError: (error) => errorState.value = error.message,
      afterSubmit: (_) => context.navigator.pushNamedAndRemoveUntil(HomeScreen.route, (_) => false),
    );
  }

  Future<void> navigateToSignIn() async {
    await context.navigator.pushReplacementNamed(SignInScreen.route);
  }

  return SignUpScreenState(
    emailFieldState: emailFieldState,
    passwordFieldState: passwordFieldState,
    firstNameFieldState: firstNameFieldState,
    lastNameFieldState: lastNameFieldState,
    userTypeState: userTypeState,
    onSignUp: onSignUp,
    submitState: submitState,
    isSubmitEnabled: isSubmitEnabled,
    submitError: errorState.value,
    onSignIn: navigateToSignIn,
  );
}
