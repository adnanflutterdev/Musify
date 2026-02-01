import 'package:flutter/material.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/spacers.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasLeading = true,
    this.trailing,
    this.extraPopFunction,
  });
  final bool hasLeading;
  final Widget title;
  final Widget? trailing;
  final void Function()? extraPopFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          bottom: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            if (!hasLeading) w20,
            if (hasLeading)
              IconButton(
                onPressed: () {
                  extraPopFunction != null ? extraPopFunction!() : null;
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColors.surfaceWhite),
              ),
            Expanded(child: title),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
