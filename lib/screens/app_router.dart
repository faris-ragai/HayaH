// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import 'doctor_shell_screen.dart';
import 'login_screen.dart';
import 'no_access_screen.dart';
import 'patient_file_screen.dart';
import 'patient_shell_screen.dart';

/// After login / register: open the doctor or the patient tabs.
void goToHome(BuildContext context) {
  final isDoctor = AuthService.instance.isDoctor;
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => isDoctor ? const DoctorShellScreen() : const PatientShellScreen(),
    ),
    (route) => false,
  );
}

void goToLogin(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
}

/// Doctor opens a patient: full file if allowed, otherwise "No access".
void openPatient(BuildContext context, Patient patient) {
  final doctor = AuthService.instance.currentDoctor;
  final allowed = doctor != null &&
      PatientService.instance.isAllowed(patient.nationalId, doctor.nationalId);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          allowed ? PatientFileScreen(patient: patient) : NoAccessScreen(patient: patient),
    ),
  );
}
