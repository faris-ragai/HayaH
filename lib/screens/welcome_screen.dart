import 'package:flutter/material.dart';
import '../service/settings_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/screen_scaffold.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return ScreenScaffold(
          title: 'Welcome',
          footer: AppButton(
            label: 'Continue',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.tint,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'Logo',
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Doctor and Patient App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
              ),
              const SizedBox(height: 6),
              const Text('Choose your language',
                  textAlign: TextAlign.center, style: AppText.sub),
              const SizedBox(height: 26),
              InfoCard(
                tint: settings.isArabic,
                onTap: () => settings.setArabic(true),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('العربية', style: AppText.title),
                    Text('Default',
                        style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InfoCard(
                tint: !settings.isArabic,
                onTap: () => settings.setArabic(false),
                child: const Text('English', style: AppText.title),
              ),
            ],
          ),
        );
      },
    );
  }
}
