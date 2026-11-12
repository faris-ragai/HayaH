// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/sync_status.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../service/settings_service.dart';
import '../widgets/allergies_card.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/pill.dart';
import '../widgets/roshetta_tile.dart';
import '../widgets/row_card.dart';
import '../widgets/screen_scaffold.dart';
import 'allowed_doctors_screen.dart';
import 'app_router.dart';
import 'history_log_screen.dart';
import 'my_qr_screen.dart';
import 'roshetta_detail_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return SizedBox.shrink();
    final service = PatientService.instance;
    final settings = SettingsService.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([service, settings, AuthService.instance]),
      builder: (context, _) {
        final roshettas = service.roshettas(patient.nationalId);
        final allowedCount = service.allowedDoctors(patient.nationalId).length;
        final logCount = service.logs(patient.nationalId).length;
        return ScreenScaffold(
          title: context.tr('Hello, {name}', {'name': patient.firstName}),
          trailing: Pill(text: context.tr(settings.status.label)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AllergiesCard(patient: patient),
              kGap,
              AppButton(
                label: context.tr('Show my QR'),
                onPressed: () => pushScreen(context, MyQrScreen()),
              ),
              if (roshettas.isNotEmpty) ...[
                kGap,
                Text(context.tr('Latest roshetta'), style: AppText.label),
                SizedBox(height: 6),
                RoshettaTile(
                  roshetta: roshettas.first,
                  onTap: () =>
                      pushScreen(context, RoshettaDetailScreen(roshetta: roshettas.first)),
                ),
              ],
              kGap,
              RowCard(
                title: context.tr('Allowed doctors'),
                trailing: Pill(text: context.tr('{n} doctors', {'n': '$allowedCount'})),
                onTap: () => pushScreen(context, AllowedDoctorsScreen()),
              ),
              kGap,
              RowCard(
                title: context.tr('History log'),
                trailing: Pill(text: context.tr('{n} entries', {'n': '$logCount'})),
                onTap: () => pushScreen(context, HistoryLogScreen(patient: patient)),
              ),
            ],
          ),
        );
      },
    );
  }
}
