import 'package:flutter/material.dart';
import '../model/date_format.dart';
import '../service/auth_service.dart';
import '../service/settings_service.dart';
import '../model/sync_status.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
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
          title: 'Settings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Language', style: AppText.title),
                    const SizedBox(height: 8),
                    Row(
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
                    ),
                  ],
                ),
              ),
              kGap,
              InfoCard(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SyncStatesScreen()),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sync status', style: AppText.title),
                        Pill(text: settings.status.label),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Last sync: ${formatDateTime(settings.lastSync)}',
                        style: AppText.sub),
                  ],
                ),
              ),
              kGap,
              AppButton(
                label: 'Refresh now',
                primary: false,
                onPressed: settings.refreshNow,
              ),
              kGap,
              AppButton(
                label: 'Logout',
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
