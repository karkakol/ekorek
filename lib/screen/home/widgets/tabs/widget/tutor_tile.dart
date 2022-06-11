import 'package:ekorek/model/user/user.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: Card(
        child: ListTile(
          title: Text(tutor.fullName),
          subtitle: Text(tutor.city),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((tutor as UserTutor).subjects[subject].toString()),
                SizedBox(width: 4),
                Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
