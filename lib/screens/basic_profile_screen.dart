// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';

/// What a doctor without permission sees: name and picture only.
class BasicProfileScreen extends StatelessWidget {
  const BasicProfileScreen({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('Profile'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 14),
          Center(child: AvatarCircle(initials: patient.initials)),
          SizedBox(height: 10),
          Text(patient.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink)),
          SizedBox(height: 8),
          Center(child: Pill(text: context.tr('Basic info only'))),
          SizedBox(height: 18),
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr('National ID'), style: AppText.label),
                SizedBox(height: 4),
                Text(context.tr('[Hidden]'), style: AppText.value),
              ],
            ),
          ),
          kGap,
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr('Medical file'), style: AppText.label),
                SizedBox(height: 4),
                Text(context.tr('Only doctors allowed by the patient can open it.'),
                    style: AppText.value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
