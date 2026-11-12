import 'package:flutter/material.dart';
import '../service/settings_service.dart';
import 'pill.dart';

/// "العربية" / "English" switch.
class LanguagePills extends StatelessWidget {
  const LanguagePills({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Pill(
          text: 'العربية',
          selected: settings.isArabic,
          onTap: () => settings.setArabic(true),
        ),
        Pill(
          text: 'English',
          selected: !settings.isArabic,
          onTap: () => settings.setArabic(false),
        ),
      ],
    );
  }
}
