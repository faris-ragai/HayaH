// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/app_image.dart';
import '../widgets/image_picker_sheet.dart';
import '../widgets/screen_scaffold.dart';

class NewRoshettaScreen extends StatefulWidget {
  const NewRoshettaScreen({super.key, required this.patient});

  final Patient patient;

  @override
  State<NewRoshettaScreen> createState() => _NewRoshettaScreenState();
}

class _NewRoshettaScreenState extends State<NewRoshettaScreen> {
  final _medicine = TextEditingController();
  final _description = TextEditingController();
  late final TextEditingController _doctorName;
  String? _pictureId;

  @override
  void initState() {
    super.initState();
    _doctorName = TextEditingController(
      text: AuthService.instance.currentDoctor?.displayName ?? '',
    );
  }

  @override
  void dispose() {
    _medicine.dispose();
    _description.dispose();
    _doctorName.dispose();
    super.dispose();
  }

  Future<void> _togglePicture() async {
    if (_pictureId != null) {
      setState(() => _pictureId = null);
      return;
    }
    final id = await pickImageWithSheet(context);
    if (id != null && mounted) setState(() => _pictureId = id);
  }

  void _save() {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return;
    if (_medicine.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.tr('Enter the medicine name'))));
      return;
    }
    PatientService.instance.addRoshetta(
      patient: widget.patient,
      doctor: doctor,
      medicine: _medicine.text.trim(),
      doctorName: _doctorName.text.trim().isEmpty ? doctor.displayName : _doctorName.text.trim(),
      description: _description.text.trim(),
      pictureId: _pictureId,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: context.tr('New roshetta'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(label: context.tr('Medicine name'), controller: _medicine),
          kGap,
          AppTextField(label: context.tr('Doctor name'), controller: _doctorName),
          kGap,
          AppTextField(label: context.tr('Description'), controller: _description, maxLines: 5),
          kGap,
          AppImage(
            imageId: _pictureId,
            placeholder: context.tr('[Roshetta picture]'),
            height: _pictureId == null ? 76 : 200,
            radius: 14,
          ),
          kGap,
          AppButton(
            label: _pictureId != null ? context.tr('Remove picture') : context.tr('Add picture'),
            primary: false,
            onPressed: _togglePicture,
          ),
          kGap,
          AppButton(label: context.tr('Save roshetta'), onPressed: _save),
        ],
      ),
    );
  }
}
