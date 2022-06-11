import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/user/user.dart' ;
import 'package:ekorek/screen/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/user/user.dart';

class TutorInfo extends StatelessWidget {
  final UserTutor tutor;
  final String subject;

  const TutorInfo({
    Key? key,
    required this.tutor,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => ProfileScreen.navigate(context: context, user: tutor),
      leading: const Icon(Icons.school, color: AppColors.primaryColor),
      contentPadding: const EdgeInsets.all(24),
      title: Text(tutor.fullName),
      subtitle: Text(subject),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(NumberFormat.currency(locale: 'PL').format(tutor.subjects[subject])),
            const SizedBox(width: 4),
            const Icon(
              Icons.monetization_on_outlined,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
