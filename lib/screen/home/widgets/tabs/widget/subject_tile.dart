import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(
            subjectName,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
