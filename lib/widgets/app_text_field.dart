import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.obscure = false,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onSubmitted,
    this.suffix,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final bool obscure;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: AppText.label),
          const SizedBox(height: 5),
        ],
        TextField(
          controller: controller,
          obscureText: obscure,
          readOnly: readOnly,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          onTap: onTap,
          onSubmitted: onSubmitted,
          style: const TextStyle(fontSize: 14, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9AA39B)),
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffix,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            border: appFieldBorder(),
            enabledBorder: appFieldBorder(),
            focusedBorder: appFieldBorder(AppColors.green, 1.4),
          ),
        ),
      ],
    );
  }
}
