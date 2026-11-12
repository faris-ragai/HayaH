// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/roshetta.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/app_image.dart';
import '../widgets/screen_scaffold.dart';

/// Read-only roshetta (the patient cannot edit it).
class RoshettaDetailScreen extends StatelessWidget {
  const RoshettaDetailScreen({super.key, required this.roshetta});

  final Roshetta roshetta;

  Widget _field(String label, String value, {bool bold = true}) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.label),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.ink,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('Roshetta'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: roshetta.hasPicture
                ? () => showImageViewer(
                    context, roshetta.pictureId, context.tr('[Roshetta picture]'))
                : null,
            child: AppImage(
              imageId: roshetta.pictureId,
              placeholder: context.tr('[No picture]'),
              height: 184,
              radius: 14,
            ),
          ),
          kGap,
          _field(context.tr('Medicine name'), roshetta.medicine),
          kGap,
          _field(context.tr('Doctor name'), roshetta.doctorName),
          kGap,
          _field(context.tr('Description'), roshetta.description, bold: false),
          SizedBox(height: 10),
          Text(context.tr('Read only. Only the doctor can write roshettas.'),
              style: AppText.note),
        ],
      ),
    );
  }
}
