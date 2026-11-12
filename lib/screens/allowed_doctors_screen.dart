// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/doctor_picker_sheet.dart';
import '../widgets/doctor_tile.dart';
import '../widgets/empty_message.dart';
import '../widgets/note_text.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';

/// Patient decides which doctors can open the file.
class AllowedDoctorsScreen extends StatelessWidget {
  const AllowedDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return SizedBox.shrink();
    final service = PatientService.instance;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final doctors = service.allowedDoctors(patient.nationalId);
        return ScreenScaffold(
          title: context.tr('Allowed doctors'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final d in doctors) ...[
                DoctorTile(
                  doctor: d,
                  trailing: Pill(
                    text: context.tr('Remove'),
                    onTap: () => service.removeDoctor(patient.nationalId, d.nationalId),
                  ),
                ),
                kGap,
              ],
              if (doctors.isEmpty) EmptyMessage(context.tr('No doctor is allowed yet.')),
              AppButton(
                label: context.tr('Allow a doctor'),
                onPressed: () => showDoctorPickerSheet(context, patient.nationalId),
              ),
              SizedBox(height: 10),
              NoteText(context.tr('Doctors can open your file only if you allow them.'),
                  center: false),
            ],
          ),
        );
      },
    );
  }
}
