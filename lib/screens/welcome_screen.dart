// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
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
          title: context.tr('Welcome'),
          footer: AppButton(
            label: context.tr('Continue'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LoginScreen()),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.tint,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    context.tr('Logo'),
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                context.tr('Doctor and Patient App'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
              ),
              SizedBox(height: 6),
              Text(context.tr('Choose your language'),
                  textAlign: TextAlign.center, style: AppText.sub),
              SizedBox(height: 26),
              InfoCard(
                tint: settings.isArabic,
                onTap: () => settings.setArabic(true),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('العربية', style: AppText.title),
                    Text(context.tr('Default'),
                        style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              InfoCard(
                tint: !settings.isArabic,
                onTap: () => settings.setArabic(false),
                child: Text('English', style: AppText.title),
              ),
            ],
          ),
        );
      },
    );
  }
}
