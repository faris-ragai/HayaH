// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_button.dart';
import 'app_theme.dart';
import 'avatar_circle.dart';
import 'image_picker_sheet.dart';

/// "+ Add picture" row used on the register screens.
/// Picks a real picture and tells the screen its id through [onChanged].
class PicturePickerRow extends StatefulWidget {
  const PicturePickerRow({super.key, this.onChanged});

  final ValueChanged<String?>? onChanged;

  @override
  State<PicturePickerRow> createState() => _PicturePickerRowState();
}

class _PicturePickerRowState extends State<PicturePickerRow> {
  String? _id;

  Future<void> _pick() async {
    final id = await pickImageWithSheet(context);
    if (id == null) return;
    setState(() => _id = id);
    widget.onChanged?.call(id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_id == null)
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
            child: Icon(Icons.add, color: AppColors.green),
          )
        else
          AvatarCircle(initials: '', size: 52, imageId: _id),
        SizedBox(width: 10),
        Expanded(
          child: AppButton(
            label: _id == null ? context.tr('Add picture') : context.tr('Change picture'),
            primary: false,
            onPressed: _pick,
          ),
        ),
      ],
    );
  }
}
