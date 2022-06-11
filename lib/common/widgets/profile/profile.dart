import 'package:ekorek/model/subject/subject.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final User user;

  const Profile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildAddress(context),
          if (user is UserTutor) _buildSubjects(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          user.fullName,
          style: context.themeData.textTheme.headline5,
        ),
        SizedBox(width: 16),
        Material(
          elevation: 2,
          color: context.themeData.primaryColor,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              user.type.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Address",
                      style: context.themeData.textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    user.postalCode + " " + user.city,
                    style: context.themeData.textTheme.bodyMedium,
                  ),
                  Text(
                    user.street + " " + user.number,
                    style: context.themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
              IconButton(
                onPressed: () => MapsLauncher.launchQuery(user.queryAddress),
                icon: Icon(
                  Icons.location_on_rounded,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjects(BuildContext context) {
    final subjects = (user as UserTutor).subjectsList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubject(Subject subject) {
    return Tooltip(
      message: "${subject.pricePerHour}zł per hour",
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
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      child: Material(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            subject.name.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
