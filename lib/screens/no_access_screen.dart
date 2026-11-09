import 'package:flutter/material.dart';
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
      title: 'Patient file',
      footer: AppButton(
        label: 'Back to search',
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
            child: const Icon(Icons.lock_outline, size: 34, color: AppColors.green),
          ),
          const SizedBox(height: 14),
          const Text('No access',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'This patient has not allowed you to open the file. Ask them to allow you or show their QR.',
              textAlign: TextAlign.center,
              style: AppText.sub,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: 220,
            child: AppButton(
              label: 'View basic info',
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
