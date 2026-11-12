// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snack.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/national_id_field.dart';
import '../widgets/password_field.dart';
import '../widgets/picture_picker_row.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
import 'register_doctor_screen.dart';

class RegisterPatientScreen extends StatefulWidget {
  const RegisterPatientScreen({super.key});

  @override
  State<RegisterPatientScreen> createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final _name = TextEditingController();
  final _id = TextEditingController();
  final _password = TextEditingController();
  String? _picture;

  @override
  void dispose() {
    _name.dispose();
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  void _create() {
    final error = AuthService.instance.registerPatient(
      name: _name.text,
      id: _id.text,
      password: _password.text,
      picture: _picture,
    );
    if (error != null) {
      showSnack(context, context.tr(error));
      return;
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('New patient'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PicturePickerRow(onChanged: (id) => _picture = id),
          kGap,
          AppTextField(label: context.tr('Full name'), controller: _name),
          kGap,
          NationalIdField(controller: _id, label: 'National ID (your user ID)'),
          kGap,
          PasswordField(controller: _password),
          kGap,
          AppButton(label: context.tr('Create account'), onPressed: _create),
          SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => RegisterDoctorScreen()),
            ),
            child: Text(context.tr('Are you a doctor? Register as doctor'), style: AppText.sub),
          ),
        ],
      ),
    );
  }
}
