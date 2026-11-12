// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_button.dart';
import 'app_theme.dart';

/// Bottom sheet: "Lab result" or "X-ray". Returns the English key, or null.
Future<String?> showReportTypeSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.bg,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.tr('Choose the type'), style: AppText.title),
            SizedBox(height: 10),
            AppButton(
              label: context.tr('Lab result'),
              primary: false,
              onPressed: () => Navigator.of(sheetContext).pop('Lab result'),
            ),
            kGap,
            AppButton(
              label: context.tr('X-ray'),
              primary: false,
              onPressed: () => Navigator.of(sheetContext).pop('X-ray'),
            ),
          ],
        ),
      ),
    ),
  );
}
