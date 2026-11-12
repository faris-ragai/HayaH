import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Small grey explanation text under a form or list.
class NoteText extends StatelessWidget {
  const NoteText(this.text, {super.key, this.center = true});

  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: AppText.note,
    );
  }
}
