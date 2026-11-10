// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/date_format.dart';
import '../model/medical_entry.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// One medical-history entry (date, doctor, details).
class EntryCard extends StatelessWidget {
  const EntryCard({super.key, required this.entry, this.onTap});

  final MedicalEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(formatDate(entry.date, ar: context.isAr), style: AppText.title),
              Text(entry.doctorName, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
            ],
          ),
          const SizedBox(height: 5),
          Text(entry.details, style: AppText.value),
        ],
      ),
    );
  }
}
