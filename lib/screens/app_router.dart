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
import 'welcome_screen.dart';

/// First screen of the app: the home tabs if someone is already logged in
/// (stay logged in), otherwise the welcome screen.
Widget startScreen() {
  final auth = AuthService.instance;
  if (auth.currentUser == null) return WelcomeScreen();
  return auth.isDoctor ? DoctorShellScreen() : PatientShellScreen();
}

/// After login / register: open the doctor or the patient tabs.
void goToHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => startScreen()),
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

/// Open another screen on top of the current one.
Future<T?> pushScreen<T>(BuildContext context, Widget screen) {
  return Navigator.of(context).push<T>(MaterialPageRoute<T>(builder: (_) => screen));
}
