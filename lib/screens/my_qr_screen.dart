import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/qr_view.dart';
import '../widgets/screen_scaffold.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    if (user == null) return const SizedBox.shrink();
    return ScreenScaffold(
      title: 'My QR',
      footer: AppButton(
        label: 'Back',
        primary: false,
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outline),
            ),
            child: QrView(data: user.qrData),
          ),
          const SizedBox(height: 18),
          Text(user.displayName,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 6),
          Text('ID ${user.nationalId}',
              style: const TextStyle(fontSize: 12.5, color: AppColors.muted)),
          const SizedBox(height: 4),
          const Text('Show this to your doctor',
              style: TextStyle(fontSize: 12.5, color: AppColors.muted)),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Made from your national ID. A doctor you allowed sees your full file; anyone else sees basic info only.',
              textAlign: TextAlign.center,
              style: AppText.note,
            ),
          ),
        ],
      ),
    );
  }
}
