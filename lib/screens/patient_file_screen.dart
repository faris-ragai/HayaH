import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
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
          trailing: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
            child: Text(patient.initials,
                style: const TextStyle(
                    fontSize: 10.5, fontWeight: FontWeight.w700, color: AppColors.green)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoCard(
                tint: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Allergies and chronic diseases', style: AppText.title),
                    const SizedBox(height: 5),
                    Text(patient.allergies.isEmpty ? 'None recorded' : patient.allergies,
                        style: AppText.value),
                  ],
                ),
              ),
              kGap,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Add info',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddMedicalInfoScreen(patient: patient),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'New roshetta',
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
                EntryCard(entry: e),
              ],
              kGap,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Reports',
                      primary: false,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ReportsScreen(patient: patient, canUpload: true),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButton(
                      label: 'History log',
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
            ],
          ),
        );
      },
    );
  }
}
