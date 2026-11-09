import 'package:flutter/material.dart';
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
      title: 'Search',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Search',
            hint: 'National ID or name',
            controller: _query,
            onSubmitted: (_) => setState(() {}),
            suffix: IconButton(
              icon: const Icon(Icons.search, color: AppColors.green),
              onPressed: () => setState(() {}),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Pill(text: 'By ID', selected: _byId, onTap: () => setState(() => _byId = true)),
              const SizedBox(width: 8),
              Pill(text: 'By name', selected: !_byId, onTap: () => setState(() => _byId = false)),
            ],
          ),
          kGap,
          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No patients found.',
                  textAlign: TextAlign.center, style: AppText.sub),
            ),
          for (final p in results) ...[
            InfoCard(
              onTap: () => openPatient(context, p),
              child: Row(
                children: [
                  AvatarCircle(initials: p.initials, size: 52),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: AppText.title),
                        const SizedBox(height: 3),
                        Text('ID ${p.nationalId.substring(0, 4)}...', style: AppText.sub),
                      ],
                    ),
                  ),
                  const Text('Open', style: AppText.sub),
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
