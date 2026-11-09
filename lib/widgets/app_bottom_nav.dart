import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.labels,
    required this.index,
    required this.onTap,
  });

  final List<String> labels;
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Container(
          height: 47,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFEDF0EA))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < labels.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (i == index)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(height: 3, color: AppColors.green),
                          ),
                        Text(
                          labels[i],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: i == index ? FontWeight.w700 : FontWeight.w400,
                            color: i == index ? AppColors.green : AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
