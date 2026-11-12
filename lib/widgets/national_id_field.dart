// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_text_field.dart';

/// 14-digit national ID input.
class NationalIdField extends StatelessWidget {
  const NationalIdField({
    super.key,
    required this.controller,
    this.label = 'National ID',
  });

  final TextEditingController controller;

  /// English text, translated here.
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: context.tr(label),
      hint: context.tr('14 digits'),
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 14,
    );
  }
}
