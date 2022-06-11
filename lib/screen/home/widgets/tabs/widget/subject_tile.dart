import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';

class SubjectTile extends StatelessWidget {
  final Function() onTap;
  final String subjectName;
  final bool isSelected;

  const SubjectTile({
    Key? key,
    required this.onTap,
    required this.subjectName,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          backgroundColor: AppColors.primaryColor,
          label: Text(
            subjectName.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
