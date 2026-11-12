// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_theme.dart';

/// Dropdown styled like AppTextField. [items] are English keys, translated here.
class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          items: [
            for (final t in items) DropdownMenuItem(value: t, child: Text(context.tr(t))),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            border: appFieldBorder(),
            enabledBorder: appFieldBorder(),
          ),
        ),
      ],
    );
  }
}
