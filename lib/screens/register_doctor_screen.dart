import 'package:flutter/material.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'New doctor',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PicturePickerRow(),
          kGap,
          AppTextField(label: 'Full name', controller: _name),
          kGap,
          AppTextField(
            label: 'National ID (your user ID)',
            hint: '14 digits',
            controller: _id,
            keyboardType: TextInputType.number,
            maxLength: 14,
          ),
          kGap,
          AppTextField(label: 'Specialty', controller: _specialty),
          kGap,
          AppTextField(label: 'License number', controller: _license),
          kGap,
          AppTextField(label: 'Password', controller: _password, obscure: true),
          kGap,
          AppButton(label: 'Create doctor account', onPressed: _create),
        ],
      ),
    );
  }
}
