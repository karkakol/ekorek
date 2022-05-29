import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/model/user/user_type.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final User user;

  const Profile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Type: ${user.type.display}"),
        Text("Email: ${user.email}"),
        Text("First Name: ${user.firstName}"),
        Text("Last Name: ${user.lastName}"),
      ],
    );
  }
}
