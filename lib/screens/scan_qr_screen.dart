// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
import 'search_screen.dart';

/// UI only: there is no camera. Tap the camera box to "scan" the next patient.
class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  int _next = 0;

  void _fakeScan() {
    final patients = PatientService.instance.allPatients;
    if (patients.isEmpty) return;
    final patient = patients[_next % patients.length];
    _next++;
    openPatient(context, patient);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('Scan QR'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _fakeScan,
            child: Container(
              height: 360,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.tint,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.green, width: 1.6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.tr('[Camera view]'),
                      style: TextStyle(fontSize: 12, color: AppColors.green)),
                  SizedBox(height: 6),
                  Text(context.tr('Demo: tap here to simulate a scan'),
                      style: TextStyle(fontSize: 11, color: AppColors.muted)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(context.tr('Point the camera at the patient QR'),
              textAlign: TextAlign.center, style: AppText.sub),
          SizedBox(height: 10),
          AppButton(
            label: context.tr('Enter ID instead'),
            primary: false,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
