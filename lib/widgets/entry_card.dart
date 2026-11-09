import 'package:flutter/material.dart';
import '../model/date_format.dart';
import '../model/medical_entry.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// One medical-history entry (date, doctor, details).
class EntryCard extends StatelessWidget {
  const EntryCard({super.key, required this.entry});

  final MedicalEntry entry;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(formatDate(entry.date), style: AppText.title),
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
