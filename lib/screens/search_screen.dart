// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _query;
  bool _byId = false;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = PatientService.instance.search(_query.text, byId: _byId);
    return ScreenScaffold(
      title: context.tr('Search'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: context.tr('Search'),
            hint: context.tr('National ID or name'),
            controller: _query,
            onSubmitted: (_) => setState(() {}),
            suffix: IconButton(
              icon: Icon(Icons.search, color: AppColors.green),
              onPressed: () => setState(() {}),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Pill(text: context.tr('By ID'), selected: _byId, onTap: () => setState(() => _byId = true)),
              SizedBox(width: 8),
              Pill(text: context.tr('By name'), selected: !_byId, onTap: () => setState(() => _byId = false)),
            ],
          ),
          kGap,
          if (results.isEmpty)
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(context.tr('No patients found.'),
                  textAlign: TextAlign.center, style: AppText.sub),
            ),
          for (final p in results) ...[
            InfoCard(
              onTap: () => openPatient(context, p),
              child: Row(
                children: [
                  AvatarCircle(initials: p.initials, size: 52, imageId: p.picture),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: AppText.title),
                        SizedBox(height: 3),
                        Text(context.tr('ID {id}...', {'id': p.nationalId.substring(0, 4)}), style: AppText.sub),
                      ],
                    ),
                  ),
                  Text(context.tr('Open'), style: AppText.sub),
                ],
              ),
            ),
            kGap,
          ],
        ],
      ),
    );
  }
}
