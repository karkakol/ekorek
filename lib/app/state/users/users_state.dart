import 'package:ekorek/app/state/auth/auth_state.dart';
import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/service/user_service/user_service.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../../service/users_service/users_service.dart';

class UsersState {
  final IList<model.User> tutors;
  final Function() getTutors;

  const UsersState({
    required this.tutors,
    required this.getTutors,

  });
}

class UsersStateProvider extends HookStateProviderWidget<UsersState> {
  const UsersStateProvider({Key? key}) : super(key: key);

  @override
  UsersState use() {
    final usersService = useInjected<UsersService>();

    final tutorsState = useState<IList<model.User>>(<model.User>[].lock);
    
    final usersStream = useStream(usersService.tutorsStream());

    useSimpleEffect(() async {
      if(usersStream.data==null) return;
      tutorsState.value = usersStream.data!;
    },[usersStream.data]);


    return UsersState(
        tutors: tutorsState.value,
        getTutors: () async => tutorsState.value = await usersService.getTutorsUsers(),
    );
  }
}