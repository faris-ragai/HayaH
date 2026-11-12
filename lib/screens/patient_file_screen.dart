// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/allergies_card.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/button_row.dart';
import '../widgets/entry_card.dart';
import '../widgets/note_text.dart';
import '../widgets/screen_scaffold.dart';
import 'add_medical_info_screen.dart';
import 'app_router.dart';
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
              AllergiesCard(patient: patient),
              kGap,
              ButtonRow(
                children: [
                  AppButton(
                    label: context.tr('Add info'),
                    onPressed: () => pushScreen(context, AddMedicalInfoScreen(patient: patient)),
                  ),
                  AppButton(
                    label: context.tr('New roshetta'),
                    primary: false,
                    onPressed: () => pushScreen(context, NewRoshettaScreen(patient: patient)),
                  ),
                ],
              ),
              for (final e in entries) ...[
                kGap,
                EntryCard(
                  entry: e,
                  onTap: () =>
                      pushScreen(context, AddMedicalInfoScreen(patient: patient, entry: e)),
                ),
              ],
              kGap,
              ButtonRow(
                children: [
                  AppButton(
                    label: context.tr('Reports'),
                    primary: false,
                    onPressed: () =>
                        pushScreen(context, ReportsScreen(patient: patient, canUpload: true)),
                  ),
                  AppButton(
                    label: context.tr('History log'),
                    primary: false,
                    onPressed: () => pushScreen(context, HistoryLogScreen(patient: patient)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              NoteText(context.tr('Tap an entry to edit it.')),
            ],
          ),
        );
      },
    );
  }
}
