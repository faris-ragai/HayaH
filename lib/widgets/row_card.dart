import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// Card with a title on one side and a pill / value on the other.
class RowCard extends StatelessWidget {
  const RowCard({super.key, required this.title, required this.trailing, this.onTap});

  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title, style: AppText.title), trailing],
      ),
    );
  }
}
