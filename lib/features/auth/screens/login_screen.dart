import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;

  Future<void> _signIn() async {
    if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields'), backgroundColor: AppColors.danger),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: AppColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.bgSurface,
                borderRadius: BorderRadius.circular(AppRadius.lg + 8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textDark.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.child_care, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Flexible(
                        child: Text(
                          'TinySteps',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  Text('TinySteps', style: AppTextStyles.heading1),
                  const SizedBox(height: 4),
                  const Text('Safe. Caring. Connected.', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
                  const SizedBox(height: AppSpacing.xxl),

                  // Email Field
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text('Email Address', style: AppTextStyles.labelBold.copyWith(color: AppColors.textDark)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: InputDecoration(
                      hintText: 'parent@tinysteps.com',
                      hintStyle: AppTextStyles.bodyMuted,
                      filled: true,
                      fillColor: AppColors.bgLight.withOpacity(0.5),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Password Field
                  Row(
                    children: [
                      const Icon(Icons.lock_outline, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text('Password', style: AppTextStyles.labelBold.copyWith(color: AppColors.textDark)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: AppTextStyles.bodyMuted,
                      filled: true,
                      fillColor: AppColors.bgLight.withOpacity(0.5),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Log In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement forgot password
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/register'),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppSpacing.xl),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: AppSpacing.md),
                  
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.bodyMuted.copyWith(fontSize: 10),
                        children: [
                          const TextSpan(text: 'By logging in, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: AppColors.textDark.withOpacity(0.7), fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: AppColors.textDark.withOpacity(0.7), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
