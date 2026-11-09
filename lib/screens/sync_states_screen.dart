import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(bottom: 11),
        child: InfoCard(
          tint: settings.status == status,
          onTap: () => settings.setStatus(status),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(status.label, style: AppText.title),
                  if (chip != null) Pill(text: chip),
                ],
              ),
              const SizedBox(height: 4),
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
          title: 'Sync states',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              row(SyncStatus.offline, 'No internet. Changes are saved on this device.'),
              row(SyncStatus.pending, 'Waiting for internet to send them.',
                  chip: '${settings.pendingChanges} changes'),
              row(SyncStatus.synced, 'Everything is up to date.'),
              row(SyncStatus.conflict,
                  'Same record edited twice. Latest edit is kept and the old version is saved in the history log.'),
              AppButton(
                label: 'Refresh now',
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
