import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/pic_box.dart';
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
  bool _hasPicture = false;

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

  void _save() {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return;
    if (_medicine.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter the medicine name')));
      return;
    }
    PatientService.instance.addRoshetta(
      patient: widget.patient,
      doctor: doctor,
      medicine: _medicine.text.trim(),
      doctorName: _doctorName.text.trim().isEmpty ? doctor.displayName : _doctorName.text.trim(),
      description: _description.text.trim(),
      hasPicture: _hasPicture,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'New roshetta',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(label: 'Medicine name', controller: _medicine),
          kGap,
          AppTextField(label: 'Doctor name', controller: _doctorName),
          kGap,
          AppTextField(label: 'Description', controller: _description, maxLines: 5),
          kGap,
          PicBox(
            label: _hasPicture ? '[Picture added]' : '[Roshetta picture]',
            height: 76,
            radius: 14,
          ),
          kGap,
          AppButton(
            label: _hasPicture ? 'Remove picture' : 'Add picture',
            primary: false,
            onPressed: () => setState(() => _hasPicture = !_hasPicture),
          ),
          kGap,
          AppButton(label: 'Save roshetta', onPressed: _save),
        ],
      ),
    );
  }
}
