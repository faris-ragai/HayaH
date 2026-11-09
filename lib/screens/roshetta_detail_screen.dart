import 'package:flutter/material.dart';
import '../model/roshetta.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pic_box.dart';
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
          const SizedBox(height: 4),
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
      title: 'Roshetta',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PicBox(
            label: roshetta.hasPicture ? '[Roshetta picture]' : '[No picture]',
            height: 184,
            radius: 14,
          ),
          kGap,
          _field('Medicine name', roshetta.medicine),
          kGap,
          _field('Doctor name', roshetta.doctorName),
          kGap,
          _field('Description', roshetta.description, bold: false),
          const SizedBox(height: 10),
          const Text('Read only. Only the doctor can write roshettas.',
              style: AppText.note),
        ],
      ),
    );
  }
}
