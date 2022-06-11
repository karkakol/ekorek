import 'package:ekorek/utill/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../config/app_colors.dart';

class UserAddress extends StatelessWidget {
  final User user;

  const UserAddress({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
