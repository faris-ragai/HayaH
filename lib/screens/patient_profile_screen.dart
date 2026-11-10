// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/screen_scaffold.dart';
import 'settings_screen.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late final TextEditingController _name;
  late final TextEditingController _id;

  @override
  void initState() {
    super.initState();
    final p = AuthService.instance.currentPatient;
    _name = TextEditingController(text: p?.name ?? '');
    _id = TextEditingController(text: p?.nationalId ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _id.dispose();
    super.dispose();
  }

  void _save() {
    AuthService.instance.updateName(_name.text);
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('Profile saved'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return SizedBox.shrink();
    return ScreenScaffold(
      title: context.tr('My profile'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: AvatarCircle(initials: patient.initials)),
          kGap,
          AppButton(
            label: context.tr('Change picture'),
            primary: false,
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.tr('Picture picker is not connected in this UI version'))),
            ),
          ),
          kGap,
          AppTextField(label: context.tr('Name'), controller: _name),
          kGap,
          AppTextField(
            label: context.tr('National ID (your user ID)'),
            controller: _id,
            readOnly: true,
          ),
          kGap,
          AppButton(label: context.tr('Save'), onPressed: _save),
          kGap,
          AppButton(
            label: context.tr('Settings'),
            primary: false,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            ),
          ),
          SizedBox(height: 12),
          Text(
            context.tr('Only you can change your name and picture. Doctors cannot edit them.'),
            textAlign: TextAlign.center,
            style: AppText.note,
          ),
        ],
      ),
    );
  }
}
