import 'package:ekorek/app/state/auth/auth_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AuthState {
  final AuthStatus status;
  const AuthState({required this.status});
}

class AuthStateProvider extends HookStateProviderWidget<AuthState> {
  const AuthStateProvider({Key? key}) : super(key: key);

  @override
  AuthState use() {
    getStatus(User? user) => user != null ? AuthStatus.AUTHORIZED : AuthStatus.UNAUTHORIZED;
    final statusState = useState<AuthStatus>(getStatus(FirebaseAuth.instance.currentUser));

    useStreamSubscription<User?>(
      FirebaseAuth.instance.authStateChanges(),
      (user) => statusState.value = getStatus(user),
    );

    return AuthState(status: statusState.value);
  }
}
