// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pic_box.dart';
import '../widgets/screen_scaffold.dart';

/// Lab results and X-rays. Only a doctor can upload (canUpload = true).
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key, required this.patient, required this.canUpload});

  final Patient patient;
  final bool canUpload;

  void _open(BuildContext context, String label) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PicBox(label: '[${context.tr(label)}]', radius: 0),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = PatientService.instance;
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final reports = service.reports(patient.nationalId);
        return ScreenScaffold(
          title: context.tr('Reports'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (canUpload) ...[
                AppButton(
                  label: context.tr('Upload lab result or X-ray'),
                  onPressed: () {
                    final doctor = AuthService.instance.currentDoctor;
                    if (doctor != null) service.addReport(patient, doctor);
                  },
                ),
                kGap,
              ],
              if (reports.isEmpty)
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(context.tr('No reports yet.'),
                      textAlign: TextAlign.center, style: AppText.sub),
                ),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (final r in reports)
                    GestureDetector(
                      onTap: () => _open(context, r),
                      child: PicBox(label: '[${context.tr(r)}]', radius: 14),
                    ),
                ],
              ),
              kGap,
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('Image viewer'), style: AppText.title),
                    SizedBox(height: 3),
                    Text(context.tr('Tap an image to open it full screen and zoom.'),
                        style: AppText.sub),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
