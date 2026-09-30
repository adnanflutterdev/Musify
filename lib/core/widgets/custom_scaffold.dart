import 'package:flutter/material.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.floatingActionButton,
    this.appBar,
  });
  final Widget body;
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
            Expanded(child: body),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
    );
  }
}
