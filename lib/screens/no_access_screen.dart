// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'basic_profile_screen.dart';

/// Doctor tried to open a file the patient did not allow.
class NoAccessScreen extends StatelessWidget {
  const NoAccessScreen({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('Patient file'),
      footer: AppButton(
        label: context.tr('Back to search'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        children: [
          SizedBox(height: 80),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
            child: Icon(Icons.lock_outline, size: 34, color: AppColors.green),
          ),
          SizedBox(height: 14),
          Text(context.tr('No access'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.tr('This patient has not allowed you to open the file. Ask them to allow you or show their QR.'),
              textAlign: TextAlign.center,
              style: AppText.sub,
            ),
          ),
          SizedBox(height: 22),
          SizedBox(
            width: 220,
            child: AppButton(
              label: context.tr('View basic info'),
              primary: false,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BasicProfileScreen(patient: patient)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
