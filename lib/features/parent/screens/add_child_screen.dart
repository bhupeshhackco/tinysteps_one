import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicalNotesController = TextEditingController();

  String _selectedGender = 'Male';
  DateTime? _selectedDob;

  @override
  void dispose() {
    _nameController.dispose();
    _allergiesController.dispose();
    _medicalNotesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2021),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDob = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date of birth.')),
      );
      return;
    }

    // TODO: Insert to Supabase children table with parent_id = currentUser.id

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Child added! Awaiting classroom assignment.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Add Child', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header icon
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.accent.withValues(alpha: 0.15),
                  child: const Icon(
                    Icons.child_care_rounded,
                    color: AppColors.accent,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Text(
                  'Tell us about your child',
                  style: AppTextStyles.bodyMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Text('Child Details', style: AppTextStyles.heading3),
              const SizedBox(height: AppSpacing.md),

              // Full Name
              TextFormField(
                controller: _nameController,
                style: AppTextStyles.bodyLarge,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Full name is required' : null,
                decoration: _inputDecoration(
                  label: 'Full Name',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Date of Birth
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    style: AppTextStyles.bodyLarge,
                    decoration: _inputDecoration(
                      label: 'Date of Birth',
                      icon: Icons.cake_outlined,
                    ),
                    controller: TextEditingController(
                      text: _selectedDob == null
                          ? ''
                          : '${_selectedDob!.day}/${_selectedDob!.month}/${_selectedDob!.year}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: _inputDecoration(
                  label: 'Gender',
                  icon: Icons.people_outline,
                ),
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
              const SizedBox(height: AppSpacing.md),

              // Allergies
              TextFormField(
                controller: _allergiesController,
                style: AppTextStyles.bodyLarge,
                decoration: _inputDecoration(
                  label: 'Allergies (if any)',
                  icon: Icons.warning_amber_outlined,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Medical Notes
              TextFormField(
                controller: _medicalNotesController,
                maxLines: 3,
                style: AppTextStyles.bodyLarge,
                decoration: _inputDecoration(
                  label: 'Medical Notes (if any)',
                  icon: Icons.medical_information_outlined,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),
              Text(
                'A classroom will be assigned by admin after submission.',
                style: AppTextStyles.caption,
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.buttonRadius,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  ),
                  child: Text('Add Child', style: AppTextStyles.buttonLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.labelMedium,
      prefixIcon: Icon(icon, color: AppColors.secondary),
      filled: true,
      fillColor: AppColors.bgSurface,
      border: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }
}
