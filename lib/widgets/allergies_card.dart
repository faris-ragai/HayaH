// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/localization_service.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// Green "Allergies and chronic diseases" box (patient home, files).
class AllergiesCard extends StatelessWidget {
  const AllergiesCard({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      tint: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('Allergies and chronic diseases'), style: AppText.title),
          SizedBox(height: 5),
          Text(
            patient.allergies.isEmpty ? context.tr('None recorded') : patient.allergies,
            style: AppText.value,
          ),
        ],
      ),
    );
  }
}
