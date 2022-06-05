import 'package:ekorek/model/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../../../app/state/users/users_state.dart';
import '../../../../common/widgets/text_input/text_input.dart';

class SearchTab extends HookWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersState = useProvided<UsersState>();

    final searchFieldState = useFieldState();


    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: TextInput(
            fieldState: searchFieldState,
            prefix: Icon(Icons.search),
          ),
        ),
        for(final tutor in usersState.tutors)
          Text(tutor.fullName + " " + tutor.email)
      ],
    );
  }
}
