import 'package:flutter/material.dart';
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
      title: 'Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 14),
          Center(child: AvatarCircle(initials: patient.initials)),
          const SizedBox(height: 10),
          Text(patient.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 8),
          const Center(child: Pill(text: 'Basic info only')),
          const SizedBox(height: 18),
          const InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National ID', style: AppText.label),
                SizedBox(height: 4),
                Text('[Hidden]', style: AppText.value),
              ],
            ),
          ),
          kGap,
          const InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Medical file', style: AppText.label),
                SizedBox(height: 4),
                Text('Only doctors allowed by the patient can open it.',
                    style: AppText.value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
