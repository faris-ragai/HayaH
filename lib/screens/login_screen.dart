// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr(error))));
      return;
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('Login'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: context.tr('National ID'),
            hint: context.tr('14 digits'),
            controller: _id,
            keyboardType: TextInputType.number,
            maxLength: 14,
          ),
          kGap,
          AppTextField(label: context.tr('Password'), controller: _password, obscure: true),
          kGap,
          AppButton(label: context.tr('Login'), onPressed: _login),
          kGap,
          AppButton(
            label: context.tr('Create account'),
            primary: false,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => RegisterPatientScreen()),
            ),
          ),
          SizedBox(height: 14),
          Text(
            context.tr('Arabic / English switch is in Settings'),
            textAlign: TextAlign.center,
            style: AppText.sub,
          ),
        ],
      ),
    );
  }
}
