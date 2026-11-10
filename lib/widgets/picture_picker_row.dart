// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_button.dart';
import 'app_theme.dart';

/// "+ Add picture" row used on the register screens.
/// UI only: it just toggles a "picture added" state.
class PicturePickerRow extends StatefulWidget {
  const PicturePickerRow({super.key});

  @override
  State<PicturePickerRow> createState() => _PicturePickerRowState();
}

class _PicturePickerRowState extends State<PicturePickerRow> {
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
          child: Icon(_added ? Icons.check : Icons.add, color: AppColors.green),
        ),
        SizedBox(width: 10),
        Expanded(
          child: AppButton(
            label: _added ? context.tr('Picture added') : context.tr('Add picture'),
            primary: false,
            onPressed: () => setState(() => _added = !_added),
          ),
        ),
      ],
    );
  }
}
