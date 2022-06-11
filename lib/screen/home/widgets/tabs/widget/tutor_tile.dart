import 'package:ekorek/model/user/user.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../model/user/user.dart';

class TutorTile extends StatelessWidget {
  final model.User tutor;
  final String subject;

  const TutorTile({
    Key? key,
    required this.tutor,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
