import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Attendance', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_rounded, size: 64, color: AppColors.primary.withValues(alpha: 0.4)),
            const SizedBox(height: AppSpacing.md),
            Text('Attendance History Screen', style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.sm),
            Text('Attendance records will appear here', style: AppTextStyles.bodyMuted),
          ],
        ),
      ),
    );
  }
}
