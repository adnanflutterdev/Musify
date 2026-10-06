import 'package:flutter/material.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.floatingActionButton,
    this.appBar,
    this.footer,
  });
  final Widget body;
  final Widget? footer;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final CustomAppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            ?appBar,
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: body,
            )),
            ?footer,
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
    );
  }
}
