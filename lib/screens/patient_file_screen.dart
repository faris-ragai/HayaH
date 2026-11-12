// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/app_theme.dart';
import '../widgets/entry_card.dart';
import '../widgets/info_card.dart';
import '../widgets/screen_scaffold.dart';
import 'add_medical_info_screen.dart';
import 'history_log_screen.dart';
import 'new_roshetta_screen.dart';
import 'reports_screen.dart';

/// Full patient file, as the doctor sees it.
class PatientFileScreen extends StatelessWidget {
  const PatientFileScreen({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final service = PatientService.instance;
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final entries = service.entries(patient.nationalId);
        return ScreenScaffold(
          title: patient.name,
          trailing: AvatarCircle(initials: patient.initials, size: 30, imageId: patient.picture),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoCard(
                tint: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('Allergies and chronic diseases'), style: AppText.title),
                    SizedBox(height: 5),
                    Text(patient.allergies.isEmpty ? context.tr('None recorded') : patient.allergies,
                        style: AppText.value),
                  ],
                ),
              ),
              kGap,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: context.tr('Add info'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddMedicalInfoScreen(patient: patient),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: context.tr('New roshetta'),
                      primary: false,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NewRoshettaScreen(patient: patient),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (final e in entries) ...[
                kGap,
                EntryCard(
                  entry: e,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddMedicalInfoScreen(patient: patient, entry: e),
                    ),
                  ),
                ),
              ],
              kGap,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: context.tr('Reports'),
                      primary: false,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ReportsScreen(patient: patient, canUpload: true),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: context.tr('History log'),
                      primary: false,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HistoryLogScreen(patient: patient),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(context.tr('Tap an entry to edit it.'),
                  textAlign: TextAlign.center, style: AppText.note),
            ],
          ),
        );
      },
    );
  }
}
