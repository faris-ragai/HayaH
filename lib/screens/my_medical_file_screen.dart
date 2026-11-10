// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/entry_card.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';
import 'history_log_screen.dart';
import 'reports_screen.dart';

/// Patient's own file. Read only: only a doctor can write here.
class MyMedicalFileScreen extends StatelessWidget {
  const MyMedicalFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return SizedBox.shrink();
    final service = PatientService.instance;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final entries = service.entries(patient.nationalId);
        return ScreenScaffold(
          title: context.tr('My medical file'),
          trailing: Pill(text: context.tr('Read only')),
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
              for (final e in entries) ...[
                kGap,
                EntryCard(entry: e),
              ],
              if (entries.isEmpty) ...[
                kGap,
                Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(context.tr('No entries yet. Your doctor will add them.'),
                      textAlign: TextAlign.center, style: AppText.sub),
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
                          builder: (_) => ReportsScreen(patient: patient, canUpload: false),
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
              Text(context.tr('Only your doctor can write in this file.'),
                  textAlign: TextAlign.center, style: AppText.note),
            ],
          ),
        );
      },
    );
  }
}
