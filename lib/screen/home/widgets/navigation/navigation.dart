import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTabChanged;

  const Navigation({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_rounded),
          label: 'Meetings',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
          backgroundColor: Colors.purple,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTabChanged,
    );
  }
}
