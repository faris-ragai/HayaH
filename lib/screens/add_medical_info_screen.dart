// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/date_format.dart';
import '../model/medical_entry.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/screen_scaffold.dart';

class AddMedicalInfoScreen extends StatefulWidget {
  const AddMedicalInfoScreen({super.key, required this.patient, this.entry});

  final Patient patient;

  /// When set, the screen edits this entry instead of adding a new one.
  final MedicalEntry? entry;

  @override
  State<AddMedicalInfoScreen> createState() => _AddMedicalInfoScreenState();
}

class _AddMedicalInfoScreenState extends State<AddMedicalInfoScreen> {
  static const _types = ['Note', 'Diagnosis', 'Test', 'Allergy'];

  final _details = TextEditingController();
  late final TextEditingController _dateText;
  DateTime _date = DateTime.now();
  String _type = _types.first;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    if (e != null) {
      _date = e.date;
      _type = _types.contains(e.type) ? e.type : _types.first;
      _details.text = e.details;
    }
    _dateText = TextEditingController();
  }

  @override
  void dispose() {
    _details.dispose();
    _dateText.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    setState(() => _date = picked);
  }

  void _save() {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return;
    if (_details.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.tr('Write the details first'))));
      return;
    }
    final e = widget.entry;
    if (e == null) {
      PatientService.instance.addEntry(
        patient: widget.patient,
        doctor: doctor,
        date: _date,
        type: _type,
        details: _details.text.trim(),
      );
    } else {
      PatientService.instance.editEntry(
        patient: widget.patient,
        doctor: doctor,
        entryId: e.id,
        date: _date,
        type: _type,
        details: _details.text.trim(),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _dateText.text = formatDate(_date, ar: context.isAr);
    return ScreenScaffold(
      title: widget.entry == null ? context.tr('Add medical info') : context.tr('Edit medical info'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: context.tr('Date'),
            controller: _dateText,
            readOnly: true,
            onTap: _pickDate,
          ),
          kGap,
          Text(context.tr('Type'), style: AppText.label),
          SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: _type,
            items: [
              for (final t in _types) DropdownMenuItem(value: t, child: Text(context.tr(t))),
            ],
            onChanged: (v) => setState(() => _type = v ?? _type),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.fieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.fieldBorder),
              ),
            ),
          ),
          kGap,
          AppTextField(label: context.tr('Details'), controller: _details, maxLines: 5),
          kGap,
          AppButton(label: context.tr('Save'), onPressed: _save),
          kGap,
          AppButton(
            label: context.tr('Cancel'),
            primary: false,
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 10),
          Text(context.tr('Saved with your name and the date.'), style: AppText.note),
        ],
      ),
    );
  }
}
