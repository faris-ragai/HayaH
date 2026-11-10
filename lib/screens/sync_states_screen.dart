// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/sync_status.dart';
import '../service/settings_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';

/// Shows the four sync states. Tap one to preview it as the current status.
class SyncStatesScreen extends StatelessWidget {
  const SyncStatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.instance;

    Widget row(SyncStatus status, String text, {String? chip}) {
      return Padding(
        padding: EdgeInsets.only(bottom: 11),
        child: InfoCard(
          tint: settings.status == status,
          onTap: () => settings.setStatus(status),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.tr(status.label), style: AppText.title),
                  if (chip != null) Pill(text: chip),
                ],
              ),
              SizedBox(height: 4),
              Text(text, style: AppText.sub),
            ],
          ),
        ),
      );
    }

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return ScreenScaffold(
          title: context.tr('Sync states'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              row(SyncStatus.offline, context.tr('No internet. Changes are saved on this device.')),
              row(SyncStatus.pending, context.tr('Waiting for internet to send them.'),
                  chip: context.tr('{n} changes', {'n': '${settings.pendingChanges}'})),
              row(SyncStatus.synced, context.tr('Everything is up to date.')),
              row(SyncStatus.conflict,
                  context.tr('Same record edited twice. Latest edit is kept and the old version is saved in the history log.')),
              AppButton(
                label: context.tr('Refresh now'),
                primary: false,
                onPressed: settings.refreshNow,
              ),
            ],
          ),
        );
      },
    );
  }
}
