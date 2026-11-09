import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Small rounded label ("Synced", "Read only", "2 doctors"...).
class Pill extends StatelessWidget {
  const Pill({super.key, required this.text, this.onTap, this.selected = false});

  final String text;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.green : AppColors.tint,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.green,
            ),
          ),
        ),
      ),
    );
  }
}
