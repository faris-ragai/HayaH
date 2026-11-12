// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/roshetta.dart';
import '../service/localization_service.dart';
import '../widgets/app_image.dart';
import '../widgets/app_theme.dart';
import '../widgets/label_value_card.dart';
import '../widgets/note_text.dart';
import '../widgets/screen_scaffold.dart';

/// Read-only roshetta (the patient cannot edit it).
class RoshettaDetailScreen extends StatelessWidget {
  const RoshettaDetailScreen({super.key, required this.roshetta});

  final Roshetta roshetta;

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
          LabelValueCard(
              label: context.tr('Medicine name'), value: roshetta.medicine, bold: true),
          kGap,
          LabelValueCard(
              label: context.tr('Doctor name'), value: roshetta.doctorName, bold: true),
          kGap,
          LabelValueCard(label: context.tr('Description'), value: roshetta.description),
          SizedBox(height: 10),
          NoteText(context.tr('Read only. Only the doctor can write roshettas.'), center: false),
        ],
      ),
    );
  }
}
