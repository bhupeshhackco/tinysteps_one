import 'package:flutter/material.dart';
import '../../../../core/constants/app_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Support & Help', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How can we help you?', style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.xl),
            _buildCard([
              _buildTile(
                icon: Icons.call,
                title: 'Contact Daycare',
                subtitle: 'Speak directly with the daycare staff',
                onTap: () {/* TODO: Call action */},
              ),
              _divider(),
              _buildTile(
                icon: Icons.help_outline,
                title: 'FAQ',
                subtitle: 'Find answers to common questions',
                onTap: () {/* TODO: Open FAQ */},
              ),
              _divider(),
              _buildTile(
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'Send us a message at support@tinysteps.com',
                onTap: () {/* TODO: Open email */},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() => const Divider(height: 1, color: AppColors.border);

  Widget _buildTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textMedium),
      title: Text(title, style: AppTextStyles.labelBold),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(subtitle, style: AppTextStyles.bodySmall),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}
