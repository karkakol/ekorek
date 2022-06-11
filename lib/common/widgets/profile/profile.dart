import 'package:ekorek/common/widgets/app_card/app_card.dart';
import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/model/subject/subject.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:intl/intl.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';

import '../user_address/user_address.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        UserAddress(user: user),
        if (user is UserTutor) _buildSubjects(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              user.fullName,
              style: TextStyle(
                color: AppColors.darkColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Material(
          elevation: 2,
          color: context.themeData.primaryColor,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  user.type == UserStudent ? Icons.person : Icons.school,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  user.type.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubjects(BuildContext context) {
    final subjects = (user as UserTutor).subjectsList;
    return AppCard(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Subjects",
                style: context.themeData.textTheme.bodyLarge,
              ),
            ),
            Wrap(
              children: subjects.map((e) => _buildSubject(e)).toList(),
              spacing: 8,
              runSpacing: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubject(Subject subject) {
    final price = NumberFormat.currency(locale: 'PL').format(subject.pricePerHour);
    return Tooltip(
      message: "$price per hour",
      triggerMode: TooltipTriggerMode.tap,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
      ),
      textStyle: TextStyle(
        color: AppColors.darkColor,
        fontWeight: FontWeight.bold,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: AppColors.accentColor,
            width: 1,
          ),
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            AppColors.primaryLight,
            AppColors.primaryLight.withOpacity(0.3),
            AppColors.primaryLight,
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            subject.name.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
