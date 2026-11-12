// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/user.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_image.dart';
import '../widgets/app_theme.dart';
import '../widgets/image_picker_sheet.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';

/// Lab results and X-rays. Only a doctor can upload (canUpload = true).
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key, required this.patient, required this.canUpload});

  final Patient patient;
  final bool canUpload;

  /// Doctor: choose the type, then pick the picture from gallery / camera.
  Future<void> _upload(BuildContext context) async {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return;
    final label = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.bg,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(context.tr('Choose the type'), style: AppText.title),
              SizedBox(height: 10),
              AppButton(
                label: context.tr('Lab result'),
                primary: false,
                onPressed: () => Navigator.of(sheetContext).pop('Lab result'),
              ),
              kGap,
              AppButton(
                label: context.tr('X-ray'),
                primary: false,
                onPressed: () => Navigator.of(sheetContext).pop('X-ray'),
              ),
            ],
          ),
        ),
      ),
    );
    if (label == null || !context.mounted) return;
    final imageId = await pickImageWithSheet(context);
    if (imageId == null) return;
    PatientService.instance.addReport(patient, doctor, label: label, imageId: imageId);
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
                  onPressed: () => _upload(context),
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
                      onTap: () => showImageViewer(
                          context, r.imageId, '[${context.tr(r.label)}]'),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppImage(
                            imageId: r.imageId,
                            placeholder: '[${context.tr(r.label)}]',
                            radius: 14,
                          ),
                          if (r.imageId != null)
                            PositionedDirectional(
                              start: 8,
                              bottom: 8,
                              child: Pill(text: context.tr(r.label)),
                            ),
                        ],
                      ),
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
