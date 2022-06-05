import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekorek/model/user/user.dart' as model;

class TutorTile extends StatelessWidget {
  final model.User tutor;
  const TutorTile({Key? key, required this.tutor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(tutor.fullName),
        subtitle: Text(tutor.city),
      ),
    );
  }
}
