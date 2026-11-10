// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../widgets/app_bottom_nav.dart';
import 'my_medical_file_screen.dart';
import 'my_roshettas_screen.dart';
import 'patient_home_screen.dart';
import 'patient_profile_screen.dart';

/// Patient tabs: Home, My file, Roshetta, Profile.
class PatientShellScreen extends StatefulWidget {
  const PatientShellScreen({super.key});

  @override
  State<PatientShellScreen> createState() => _PatientShellScreenState();
}

class _PatientShellScreenState extends State<PatientShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          PatientHomeScreen(),
          MyMedicalFileScreen(),
          MyRoshettasScreen(),
          PatientProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        labels: [context.tr('Home'), context.tr('My file'), context.tr('Roshetta'), context.tr('Profile')],
        index: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
