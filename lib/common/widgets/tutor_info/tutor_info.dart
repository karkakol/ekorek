import 'package:ekorek/model/user/user.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/user/user.dart';

class TutorInfo extends StatelessWidget {
  final model.UserTutor tutor;
  final String subject;

  const TutorInfo({
    Key? key,
    required this.tutor,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tutor.fullName),
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
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
