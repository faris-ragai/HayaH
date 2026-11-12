import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// Small grey label with a value under it.
class LabelValueCard extends StatelessWidget {
  const LabelValueCard({super.key, required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.label),
          const SizedBox(height: 4),
          Text(
            value,
            style: bold
                ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)
                : AppText.value,
          ),
        ],
      ),
    );
  }
}
