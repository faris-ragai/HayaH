import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Green header + body, like every screen in the UI design.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.footer,
    this.bottomBar,
    this.scroll = true,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  /// Pinned at the bottom of the screen (e.g. "Continue", "Back").
  final Widget? footer;

  /// Bottom navigation bar for the tab screens.
  final Widget? bottomBar;
  final bool scroll;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    const padding = EdgeInsets.all(14);
    return Scaffold(
      backgroundColor: AppColors.bg,
      bottomNavigationBar: bottomBar,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.green,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: 61,
              child: Row(
                children: [
                  if (canPop)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(width: 17),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing!,
                  const SizedBox(width: 17),
                ],
              ),
            ),
          ),
          Expanded(
            child: scroll
                ? SingleChildScrollView(padding: padding, child: child)
                : Padding(padding: padding, child: child),
          ),
          if (footer != null)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: footer,
              ),
            ),
        ],
      ),
    );
  }
}
