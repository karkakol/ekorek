import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/screen/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/user/user.dart';

class UserInfo extends StatelessWidget {
  final User user;
  final String subject;

  const UserInfo({
    Key? key,
    required this.user,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => ProfileScreen.navigate(context: context, user: user),
      leading: Icon(
        user is UserTutor ? Icons.school : Icons.person,
        color: user is UserTutor ? AppColors.primaryColor : Colors.green,
      ),
      contentPadding: const EdgeInsets.all(24),
      title: Text(user.fullName),
      subtitle: user is UserTutor ? Text(subject) : null,
      trailing: user is UserTutor
          ? FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(NumberFormat.currency(locale: 'PL').format((user as UserTutor).subjects[subject])),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.monetization_on_outlined,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
