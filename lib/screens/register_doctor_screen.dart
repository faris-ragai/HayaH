// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/picture_picker_row.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';

class RegisterDoctorScreen extends StatefulWidget {
  const RegisterDoctorScreen({super.key});

  @override
  State<RegisterDoctorScreen> createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _name = TextEditingController();
  final _id = TextEditingController();
  final _specialty = TextEditingController();
  final _license = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _id.dispose();
    _specialty.dispose();
    _license.dispose();
    _password.dispose();
    super.dispose();
  }

  void _create() {
    final error = AuthService.instance.registerDoctor(
      name: _name.text,
      id: _id.text,
      specialty: _specialty.text,
      licenseNumber: _license.text,
      password: _password.text,
    );
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr(error))));
      return;
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('New doctor'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PicturePickerRow(),
          kGap,
          AppTextField(label: context.tr('Full name'), controller: _name),
          kGap,
          AppTextField(
            label: context.tr('National ID (your user ID)'),
            hint: context.tr('14 digits'),
            controller: _id,
            keyboardType: TextInputType.number,
            maxLength: 14,
          ),
          kGap,
          AppTextField(label: context.tr('Specialty'), controller: _specialty),
          kGap,
          AppTextField(label: context.tr('License number'), controller: _license),
          kGap,
          AppTextField(label: context.tr('Password'), controller: _password, obscure: true),
          kGap,
          AppButton(label: context.tr('Create doctor account'), onPressed: _create),
        ],
      ),
    );
  }
}
