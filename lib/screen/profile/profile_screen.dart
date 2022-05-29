import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/screen/profile/profile_screen_args.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

import 'state/use_profile_screen_state.dart';
import 'view/profile_screen_view.dart';

class ProfileScreen extends HookWidget {
  static const route = '/profile';
  static final routeConfig = RouteConfig.material(() => const ProfileScreen());

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = context.routeArgs<ProfileScreenArgs>()!;
    final state = useProfileScreenState(args: args);
    return ProfileScreenView(state: state);
  }

  static Future<void> navigate({required BuildContext context, required User user}) async {
    await context.navigator.pushNamed(ProfileScreen.route, arguments: ProfileScreenArgs(user: user));
  }
}
