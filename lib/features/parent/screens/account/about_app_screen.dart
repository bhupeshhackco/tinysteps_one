import 'package:flutter/material.dart';
import '../../../../core/constants/app_theme.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('About App', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),

            // App Logo
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: Text('👶', style: const TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('TinySteps', style: AppTextStyles.heading1),
            Text('Version v1.0.0', style: AppTextStyles.bodyMuted),

            const SizedBox(height: AppSpacing.xxl),

            _buildCard([
              _buildInfoTile(icon: Icons.info_outline, label: 'App Name', value: 'TinySteps'),
              const Divider(height: 1, color: AppColors.border),
              _buildInfoTile(icon: Icons.tag, label: 'Version', value: 'v1.0.0'),
              const Divider(height: 1, color: AppColors.border),
              _buildInfoTile(icon: Icons.build_outlined, label: 'Build', value: '2026.03'),
              const Divider(height: 1, color: AppColors.border),
              _buildInfoTile(icon: Icons.copyright, label: 'Developer', value: 'TinySteps Team'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String label, required String value}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textMedium),
      title: Text(label, style: AppTextStyles.bodyMuted),
      trailing: Text(value, style: AppTextStyles.labelBold),
    );
  }
}
