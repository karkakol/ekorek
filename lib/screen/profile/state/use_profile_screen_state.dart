import 'package:ekorek/model/user/user.dart' as model;
import 'package:ekorek/screen/profile/profile_screen_args.dart';

class ProfileScreenState {
  final model.User user;

  ProfileScreenState({required this.user});
}

ProfileScreenState useProfileScreenState({required ProfileScreenArgs args}) {
  return ProfileScreenState(user: args.user);
}
