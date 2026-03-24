import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../../../core/constants/app_theme.dart';

void showQRDisplaySheet(
  BuildContext context, {
  required String childId,
  required String childName,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (_) => _QRDisplaySheet(childId: childId, childName: childName),
  );
}

class _QRDisplaySheet extends StatelessWidget {
  final String childId;
  final String childName;

  const _QRDisplaySheet({
    required this.childId,
    required this.childName,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = jsonEncode({'child_id': childId, 'type': 'checkin'});

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: AppRadius.sheetRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          Text('Check-In QR Code', style: AppTextStyles.heading2),
          const SizedBox(height: AppSpacing.xs),
          Text(childName, style: AppTextStyles.bodyMuted),

          const SizedBox(height: AppSpacing.xl),

          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: AppShadows.card,
            ),
            child: QrImageView(
              data: qrData,
              size: 220,
              backgroundColor: AppColors.bgSurface,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: AppColors.textDark,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: AppColors.textDark,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Show this to your teacher to check in',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xl),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.buttonRadius,
                ),
              ),
              child: Text(
                'Close',
                style: AppTextStyles.labelBold.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
