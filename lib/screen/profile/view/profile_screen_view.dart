import 'package:ekorek/common/widgets/profile/profile.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:flutter/material.dart';

import '../state/use_profile_screen_state.dart';

class ProfileScreenView extends StatelessWidget {
  final ProfileScreenState state;

  const ProfileScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile ${state.user.fullName}"),
      ),
      body: Center(
        child: Profile(user: state.user),
      )
    );
  }
}
