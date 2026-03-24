import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import 'screens/parent_home_screen.dart';
import 'screens/my_children_screen.dart';
import 'screens/attendance_history_screen.dart';
import 'screens/parent_profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class ParentShell extends StatefulWidget {
  const ParentShell({super.key});

  @override
  State<ParentShell> createState() => _ParentShellState();
}

class _ParentShellState extends State<ParentShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ParentHomeScreen(),
    MyChildrenScreen(),
    AttendanceHistoryScreen(),
    ParentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: ParentBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
