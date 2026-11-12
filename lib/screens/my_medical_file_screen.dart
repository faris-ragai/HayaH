// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/allergies_card.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/button_row.dart';
import '../widgets/empty_message.dart';
import '../widgets/entry_card.dart';
import '../widgets/note_text.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
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
              AllergiesCard(patient: patient),
              for (final e in entries) ...[kGap, EntryCard(entry: e)],
              if (entries.isEmpty)
                EmptyMessage(context.tr('No entries yet. Your doctor will add them.')),
              kGap,
              ButtonRow(
                children: [
                  AppButton(
                    label: context.tr('Reports'),
                    primary: false,
                    onPressed: () => pushScreen(
                        context, ReportsScreen(patient: patient, canUpload: false)),
                  ),
                  AppButton(
                    label: context.tr('History log'),
                    primary: false,
                    onPressed: () => pushScreen(context, HistoryLogScreen(patient: patient)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              NoteText(context.tr('Only your doctor can write in this file.')),
            ],
          ),
        );
      },
    );
  }
}
