import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'doctor_home_screen.dart';
import 'doctor_profile_screen.dart';
import 'scan_qr_screen.dart';
import 'search_screen.dart';

/// Doctor tabs: Home, Search, Scan, Profile.
class DoctorShellScreen extends StatefulWidget {
  const DoctorShellScreen({super.key});

  @override
  State<DoctorShellScreen> createState() => _DoctorShellScreenState();
}

class _DoctorShellScreenState extends State<DoctorShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          DoctorHomeScreen(),
          SearchScreen(),
          ScanQrScreen(),
          DoctorProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        labels: const ['Home', 'Search', 'Scan', 'Profile'],
        index: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
