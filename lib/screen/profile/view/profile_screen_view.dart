import 'package:ekorek/common/widgets/profile/profile.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../state/use_profile_screen_state.dart';

class ProfileScreenView extends StatelessWidget {
  final ProfileScreenState state;

  const ProfileScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.darkColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16, vertical: 24),
        child: Profile(user: state.user),
      ),
    );
  }
}
