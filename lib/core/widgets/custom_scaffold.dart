import 'package:flutter/material.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.appBar,
    this.footer,
    required this.body,

    this.backgroundColor,
    this.floatingActionButton,

    this.haveBottomPadding = true,
  });
  final Widget body;
  final Widget? footer;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final CustomAppBar? appBar;
  final bool haveBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            ?appBar,
            Expanded(
              child: Padding(padding: const EdgeInsets.all(15.0), child: body),
            ),
            ?footer,
            if (haveBottomPadding)
              const SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
    );
  }
}
