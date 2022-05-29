import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AuthState {
  final User? user;
  const AuthState({required this.user});
}

class AuthStateProvider extends HookStateProviderWidget<AuthState> {
  const AuthStateProvider({Key? key}) : super(key: key);

  @override
  AuthState use() {
    final userState = useState<User?>(FirebaseAuth.instance.currentUser);

    useStreamSubscription<User?>(FirebaseAuth.instance.authStateChanges(), (user) {
      userState.value = user;
    });

    return AuthState(user: userState.value);
  }
}
