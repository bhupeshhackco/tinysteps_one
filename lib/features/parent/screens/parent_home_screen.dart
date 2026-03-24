import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_theme.dart';
import '../widgets/child_avatar.dart';
import '../widgets/empty_state.dart';
import '../widgets/qr_display_sheet.dart';

/// Parent Home Screen — Squad B's home base
/// TODO (Child Profiles Squad): Replace placeholder cards with child list
class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    // Router will auto-redirect to /login
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final name = user?.userMetadata?['full_name'] as String? ?? 'Parent';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('TinySteps', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text('Hello, $name 👋', style: AppTextStyles.heading1),
            Text('Your children are doing great today!', style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.lg),

            // Children List
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                const ChildAvatar(name: 'Leo', status: 'In Class', color: Colors.blue, size: 60),
                const ChildAvatar(name: 'Mia', status: 'Checked Out', color: Colors.orange, size: 60),
                const ChildAvatar(name: 'Sam', status: 'In Class', color: Colors.green, size: 60),
                const ChildAvatar(name: 'Riya', status: 'At Home', color: Colors.pink, size: 60),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xl),
            Text('Quick Actions', style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.md),

            // Quick-action cards
            _QuickActionCard(
              icon: Icons.qr_code,
              label: 'Show My QR Code',
              color: AppColors.secondary,
              onTap: () => showQRDisplaySheet(
                context,
                childId: 'dummy-child-001',
                childName: 'Leo Smith',
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Messages Section
            Text('Messages', style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const EmptyState(
                label: 'No messages yet.\nCheck back later for teacher updates!',
                icon: Icons.forum_outlined,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Upcoming Events Section
            Text('Upcoming Events', style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const EmptyState(
                label: 'No events scheduled for this week.',
                icon: Icons.event_busy_outlined,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}


class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(label, style: AppTextStyles.heading2),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: AppColors.textMuted, size: 16),
          ],
        ),
      ),
    );
  }
}
