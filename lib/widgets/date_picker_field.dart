// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/date_format.dart';
import '../service/localization_service.dart';
import 'app_text_field.dart';

/// Read-only field that opens the date picker when tapped.
class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.label,
    required this.date,
    required this.onChanged,
  });

  final String label;
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = formatDate(widget.date, ar: context.isAr);
    return AppTextField(
      label: widget.label,
      controller: _controller,
      readOnly: true,
      onTap: _pick,
    );
  }
}
