// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
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
    if (user == null) return SizedBox.shrink();
    return ScreenScaffold(
      title: context.tr('My QR'),
      footer: AppButton(
        label: context.tr('Back'),
        primary: false,
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outline),
            ),
            child: QrView(data: user.qrData),
          ),
          SizedBox(height: 18),
          Text(user.displayName,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          SizedBox(height: 6),
          Text(context.tr('ID {id}', {'id': user.nationalId}),
              style: TextStyle(fontSize: 12.5, color: AppColors.muted)),
          SizedBox(height: 4),
          Text(context.tr('Show this to your doctor'),
              style: TextStyle(fontSize: 12.5, color: AppColors.muted)),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              context.tr('Made from your national ID. A doctor you allowed sees your full file; anyone else sees basic info only.'),
              textAlign: TextAlign.center,
              style: AppText.note,
            ),
          ),
        ],
      ),
    );
  }
}
