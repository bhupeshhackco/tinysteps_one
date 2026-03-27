import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_theme.dart';

enum AttendanceState { initial, success, error }

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceState _state = AttendanceState.initial;

  void _simulateSuccess() {
    setState(() {
      _state = AttendanceState.success;
    });
  }

  void _simulateError() {
    setState(() {
      _state = AttendanceState.error;
    });
  }

  void _reset() {
    setState(() {
      _state = AttendanceState.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Attendance', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/teacher'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _buildContent(),
              ),
            ),
            if (_state != AttendanceState.initial)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: FilledButton(
                  onPressed: _reset,
                  child: const Text('Scan Again'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
            // Simulation buttons for testing
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _simulateSuccess,
                  child: const Text('Simulate Success'),
                ),
                OutlinedButton(
                  onPressed: _simulateError,
                  child: const Text('Simulate Error'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case AttendanceState.initial:
        return _buildInitialState();
      case AttendanceState.success:
        return _buildSuccessState();
      case AttendanceState.error:
        return _buildErrorState();
    }
  }

  Widget _buildInitialState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 3),
            borderRadius: BorderRadius.circular(AppRadius.md),
            color: AppColors.white.withValues(alpha: 0.1),
          ),
          child: const Center(
            child: Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Scan child QR code to mark attendance',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check_circle,
          size: 100,
          color: AppColors.success,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Aarav',
          style: AppTextStyles.heading1,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Checked In Successfully ✅',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error,
          size: 100,
          color: AppColors.danger,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Invalid QR Code',
          style: AppTextStyles.heading2.copyWith(color: AppColors.danger),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Try again',
          style: AppTextStyles.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}