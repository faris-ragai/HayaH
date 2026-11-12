// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snack.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/image_picker_sheet.dart';
import '../widgets/note_text.dart';
import '../widgets/profile_picture_block.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
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

  Future<void> _changePicture() async {
    final id = await pickImageWithSheet(context);
    if (id == null) return;
    AuthService.instance.updatePicture(id);
    if (mounted) setState(() {});
  }

  void _save() {
    AuthService.instance.updateName(_name.text);
    FocusScope.of(context).unfocus();
    showSnack(context, context.tr('Profile saved'));
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
          ProfilePictureBlock(
            initials: patient.initials,
            imageId: patient.picture,
            onChange: _changePicture,
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
            onPressed: () => pushScreen(context, SettingsScreen()),
          ),
          SizedBox(height: 12),
          NoteText(context.tr('Only you can change your name and picture. Doctors cannot edit them.')),
        ],
      ),
    );
  }
}
