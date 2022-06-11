import 'package:ekorek/model/user/user.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/app_card/app_card.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../model/user/user.dart';
import '../../../../create_appointment/state/create_appointemtn_screen_args.dart';

class TutorTile extends StatelessWidget {
  final model.UserTutor tutor;
  final String subject;
  final Function(CreateAppointmentScreenArgs) onTap;

  const TutorTile({
    Key? key,
    required this.tutor,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final args = CreateAppointmentScreenArgs(subject: subject, tutor: tutor);
        onTap(args);
      },
      child: AppCard(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
          title: Text(tutor.fullName),
          contentPadding: EdgeInsets.zero,
          subtitle: Text(tutor.city),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(tutor.subjects[subject].toString()),
                const SizedBox(width: 4),
                const Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
