import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
import 'register_patient_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _id = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    final error = AuthService.instance.login(_id.text, _password.text);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Login',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'National ID',
            hint: '14 digits',
            controller: _id,
            keyboardType: TextInputType.number,
            maxLength: 14,
          ),
          kGap,
          AppTextField(label: 'Password', controller: _password, obscure: true),
          kGap,
          AppButton(label: 'Login', onPressed: _login),
          kGap,
          AppButton(
            label: 'Create account',
            primary: false,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RegisterPatientScreen()),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Arabic / English switch is in Settings',
            textAlign: TextAlign.center,
            style: AppText.sub,
          ),
        ],
      ),
    );
  }
}
