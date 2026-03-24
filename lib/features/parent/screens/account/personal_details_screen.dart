import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_theme.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final name = user?.userMetadata?['full_name'] as String? ?? 'Parent';
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Personal Details', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Information', style: AppTextStyles.heading3),
            const SizedBox(height: AppSpacing.md),

            _buildField(label: 'Full Name', value: name, icon: Icons.person_outline),
            const SizedBox(height: AppSpacing.md),
            _buildField(label: 'Email Address', value: email, icon: Icons.email_outlined),
            const SizedBox(height: AppSpacing.md),
            _buildField(label: 'Phone Number', value: '+1 (555) 123-4567', icon: Icons.phone_outlined),

            const SizedBox(height: AppSpacing.xxl),

            Text('Emergency Contact', style: AppTextStyles.heading3),
            Text('Who should we call if we can\'t reach you?', style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.md),
            _buildField(label: 'Contact Name', value: 'Jane Smith', icon: Icons.person_outline),
            const SizedBox(height: AppSpacing.md),
            _buildField(label: 'Phone Number', value: '+1 (555) 987-6543', icon: Icons.contact_phone_outlined),

            const SizedBox(height: AppSpacing.xl),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save to Supabase
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text('Save Changes', style: AppTextStyles.buttonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required String value, required IconData icon}) {
    return TextFormField(
      initialValue: value,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.labelMedium,
        prefixIcon: Icon(icon, color: AppColors.secondary),
        filled: true,
        fillColor: AppColors.bgSurface,
        border: OutlineInputBorder(borderRadius: AppRadius.inputRadius, borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: AppRadius.inputRadius, borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: AppRadius.inputRadius, borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      ),
    );
  }
}
