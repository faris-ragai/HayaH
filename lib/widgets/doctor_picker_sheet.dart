// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import 'app_theme.dart';
import 'doctor_tile.dart';
import 'empty_message.dart';

/// Bottom sheet where a patient picks a doctor to allow.
Future<void> showDoctorPickerSheet(BuildContext context, String patientId) {
  final service = PatientService.instance;
  final options = service.notAllowedDoctors(patientId);
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.bg,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.tr('Allow a doctor'), style: AppText.title),
            SizedBox(height: 10),
            if (options.isEmpty) EmptyMessage(context.tr('All doctors are already allowed.')),
            for (final d in options) ...[
              DoctorTile(
                doctor: d,
                onTap: () {
                  service.allowDoctor(patientId, d.nationalId);
                  Navigator.of(sheetContext).pop();
                },
              ),
              kGap,
            ],
          ],
        ),
      ),
    ),
  );
}
