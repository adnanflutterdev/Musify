import 'package:flutter/material.dart';
import 'package:musify/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.hasLeading = false});
  final bool hasLeading;
  final Widget title;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(hasLeading)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: AppColors.surfaceWhite),
            ),
            Expanded(child: title),
          ],
        ),
      ),
    );
  }
}
