// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';

/// Patient decides which doctors can open the file.
class AllowedDoctorsScreen extends StatelessWidget {
  const AllowedDoctorsScreen({super.key});

  void _pickDoctor(BuildContext context, String patientId) {
    final service = PatientService.instance;
    final options = service.notAllowedDoctors(patientId);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bg,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.tr('Allow a doctor'), style: AppText.title),
                SizedBox(height: 10),
                if (options.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(context.tr('All doctors are already allowed.'), style: AppText.sub),
                  ),
                for (final d in options) ...[
                  InfoCard(
                    onTap: () {
                      service.allowDoctor(patientId, d.nationalId);
                      Navigator.of(sheetContext).pop();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.displayName, style: AppText.title),
                        SizedBox(height: 3),
                        Text(d.specialty, style: AppText.sub),
                      ],
                    ),
                  ),
                  kGap,
                ],
              ],
            ),
          ),
        );
      },
    );
  }

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
                InfoCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.displayName, style: AppText.title),
                            SizedBox(height: 3),
                            Text(d.specialty, style: AppText.sub),
                          ],
                        ),
                      ),
                      Pill(
                        text: context.tr('Remove'),
                        onTap: () =>
                            service.removeDoctor(patient.nationalId, d.nationalId),
                      ),
                    ],
                  ),
                ),
                kGap,
              ],
              if (doctors.isEmpty)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(context.tr('No doctor is allowed yet.'),
                      textAlign: TextAlign.center, style: AppText.sub),
                ),
              AppButton(
                label: context.tr('Allow a doctor'),
                onPressed: () => _pickDoctor(context, patient.nationalId),
              ),
              SizedBox(height: 10),
              Text(context.tr('Doctors can open your file only if you allow them.'),
                  style: AppText.note),
            ],
          ),
        );
      },
    );
  }
}
