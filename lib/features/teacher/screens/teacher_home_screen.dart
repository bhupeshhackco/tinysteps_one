import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_theme.dart';

/// Teacher Home Screen — Squad C's home base
/// TODO (Attendance/QR Squad): Wire up QR scanner + attendance log
class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final name = user?.userMetadata?['full_name'] as String? ?? 'Teacher';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Teacher Dashboard', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good day, $name 📋', style: AppTextStyles.heading1),
            Text("Ready to take attendance?", style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.xl),

            // Scan QR button – primary CTA
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {/* TODO: push QR scanner screen */},
                icon: const Icon(Icons.qr_code_scanner, color: AppColors.white),
                label: const Text(
                  'Scan QR Code',
                  style: TextStyle(fontSize: 18, color: AppColors.white),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text("Recent Scans", style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.md),

            _AttendanceTile(name: 'Leo Smith', time: '08:15 AM', status: 'Checked In'),
            const SizedBox(height: AppSpacing.sm),
            _AttendanceTile(name: 'Mia Brown', time: '08:22 AM', status: 'Checked In'),
            const SizedBox(height: AppSpacing.sm),
            _AttendanceTile(name: 'Noah Wilson', time: '08:30 AM', status: 'Checked In'),
          ],
        ),
      ),
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  final String name;
  final String time;
  final String status;

  const _AttendanceTile({required this.name, required this.time, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.labelBold),
              Text(time, style: AppTextStyles.bodyMuted.copyWith(fontSize: 12)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
