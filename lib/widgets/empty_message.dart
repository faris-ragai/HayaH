import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Centered grey text for empty lists ("No roshettas yet.").
class EmptyMessage extends StatelessWidget {
  const EmptyMessage(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(text, textAlign: TextAlign.center, style: AppText.sub),
    );
  }
}
