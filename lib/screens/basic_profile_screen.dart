// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/localization_service.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/label_value_card.dart';
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
          Center(child: AvatarCircle(initials: patient.initials, imageId: patient.picture)),
          SizedBox(height: 10),
          Text(
            patient.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink),
          ),
          SizedBox(height: 8),
          Center(child: Pill(text: context.tr('Basic info only'))),
          SizedBox(height: 18),
          LabelValueCard(label: context.tr('National ID'), value: context.tr('[Hidden]')),
          kGap,
          LabelValueCard(
            label: context.tr('Medical file'),
            value: context.tr('Only doctors allowed by the patient can open it.'),
          ),
        ],
      ),
    );
  }
}
