import 'package:ekorek/app/state/auth/auth_state.dart';
import 'package:ekorek/app/state/auth/auth_status.dart';
import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/service/user_service/user_service.dart';

import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class UserState {
  final model.User? user;
  final Future<model.User?> Function() refreshUser;

  const UserState({
    required this.user,
    required this.refreshUser,
  });
}

class UserStateProvider extends HookStateProviderWidget<UserState> {
  const UserStateProvider({Key? key}) : super(key: key);

  @override
  UserState use() {
    final authState = useProvided<AuthState>();
    final userState = useState<model.User?>(null);
    final userService = useInjected<UserService>();

    useSimpleEffect(() async {
      if (authState.status == AuthStatus.AUTHORIZED) userState.value = await userService.getCurrentUser();
      else userState.value = null;
    }, [authState.status]);

    return UserState(
      user: userState.value,
      refreshUser: () async {
        final user = await userService.getCurrentUser();
        userState.value = user;
        return user;
      },
    );
  }
}
