import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
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
      title: 'New patient',
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
          AppTextField(label: 'Password', controller: _password, obscure: true),
          kGap,
          AppButton(label: 'Create account', onPressed: _create),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const RegisterDoctorScreen()),
            ),
            child: const Text('Are you a doctor? Register as doctor',
                style: AppText.sub),
          ),
        ],
      ),
    );
  }
}
