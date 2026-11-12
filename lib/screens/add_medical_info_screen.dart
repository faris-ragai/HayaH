// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/medical_entry.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/app_snack.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/note_text.dart';
import '../widgets/screen_scaffold.dart';

/// Doctor adds a new entry, or edits an old one when [entry] is set.
class AddMedicalInfoScreen extends StatefulWidget {
  const AddMedicalInfoScreen({super.key, required this.patient, this.entry});

  final Patient patient;
  final MedicalEntry? entry;

  @override
  State<AddMedicalInfoScreen> createState() => _AddMedicalInfoScreenState();
}

class _AddMedicalInfoScreenState extends State<AddMedicalInfoScreen> {
  static const _types = ['Note', 'Diagnosis', 'Test', 'Allergy'];

  final _details = TextEditingController();
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
  }

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  void _save() {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return;
    if (_details.text.trim().isEmpty) {
      showSnack(context, context.tr('Write the details first'));
      return;
    }
    final service = PatientService.instance;
    final e = widget.entry;
    if (e == null) {
      service.addEntry(
        patient: widget.patient,
        doctor: doctor,
        date: _date,
        type: _type,
        details: _details.text.trim(),
      );
    } else {
      service.editEntry(
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
    return ScreenScaffold(
      title: widget.entry == null
          ? context.tr('Add medical info')
          : context.tr('Edit medical info'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DatePickerField(
            label: context.tr('Date'),
            date: _date,
            onChanged: (d) => setState(() => _date = d),
          ),
          kGap,
          AppDropdown(
            label: context.tr('Type'),
            value: _type,
            items: _types,
            onChanged: (v) => setState(() => _type = v),
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
          NoteText(context.tr('Saved with your name and the date.'), center: false),
        ],
      ),
    );
  }
}
