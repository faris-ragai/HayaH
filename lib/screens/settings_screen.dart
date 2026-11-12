// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/date_format.dart';
import '../model/sync_status.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/settings_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/language_pills.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
import 'sync_states_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return ScreenScaffold(
          title: context.tr('Settings'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('Language'), style: AppText.title),
                    SizedBox(height: 8),
                    LanguagePills(),
                  ],
                ),
              ),
              kGap,
              InfoCard(
                onTap: () => pushScreen(context, SyncStatesScreen()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(context.tr('Sync status'), style: AppText.title),
                        Pill(text: context.tr(settings.status.label)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      context.tr('Last sync: {date}',
                          {'date': formatDateTime(settings.lastSync, ar: context.isAr)}),
                      style: AppText.sub,
                    ),
                  ],
                ),
              ),
              kGap,
              AppButton(
                label: context.tr('Refresh now'),
                primary: false,
                onPressed: settings.refreshNow,
              ),
              kGap,
              AppButton(
                label: context.tr('Logout'),
                primary: false,
                onPressed: () {
                  AuthService.instance.logout();
                  goToLogin(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
