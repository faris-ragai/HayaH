// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/image_picker_sheet.dart';
import '../widgets/screen_scaffold.dart';
import 'settings_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late final TextEditingController _name;
  late final TextEditingController _id;
  late final TextEditingController _specialty;
  late final TextEditingController _license;

  @override
  void initState() {
    super.initState();
    final d = AuthService.instance.currentDoctor;
    _name = TextEditingController(text: d?.displayName ?? '');
    _id = TextEditingController(text: d?.nationalId ?? '');
    _specialty = TextEditingController(text: d?.specialty ?? '');
    _license = TextEditingController(text: d?.licenseNumber ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _id.dispose();
    _specialty.dispose();
    _license.dispose();
    super.dispose();
  }

  Future<void> _changePicture() async {
    final id = await pickImageWithSheet(context);
    if (id == null) return;
    AuthService.instance.updatePicture(id);
    if (mounted) setState(() {});
  }

  void _save() {
    AuthService.instance.updateDoctor(
      name: _name.text,
      specialty: _specialty.text,
      licenseNumber: _license.text,
    );
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('Profile saved'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return SizedBox.shrink();
    return ScreenScaffold(
      title: context.tr('My profile'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: AvatarCircle(initials: doctor.initials, imageId: doctor.picture)),
          kGap,
          AppButton(
            label: context.tr('Change picture'),
            primary: false,
            onPressed: _changePicture,
          ),
          kGap,
          AppTextField(label: context.tr('Name'), controller: _name),
          kGap,
          AppTextField(label: context.tr('National ID'), controller: _id, readOnly: true),
          kGap,
          AppTextField(label: context.tr('Specialty'), controller: _specialty),
          kGap,
          AppTextField(label: context.tr('License number'), controller: _license),
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
        ],
      ),
    );
  }
}
