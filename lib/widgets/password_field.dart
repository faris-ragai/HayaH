// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_text_field.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: context.tr('Password'),
      controller: controller,
      obscure: true,
    );
  }
}
