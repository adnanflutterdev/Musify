import 'package:flutter/widgets.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/extension/number_extention.dart';
import 'package:musify/core/extension/size_extention.dart';

class SongListLoader extends StatelessWidget {
  const SongListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = 15;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(
                width: width.getPercentage(40),
                height: height + 10,
                decoration: getDecoration(context),
              ),
              Container(
                width: width.getPercentage(15),
                height: height,
                decoration: getDecoration(context),
              ),
            ],
          ),
          AppSpacing.h12,
          Container(
            width: width,
            decoration: getDecoration(context),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              children: List.generate(
                3,
                (index) => Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      width: width.getPercentage(28),
                      height: width.getPercentage(28),
                      decoration: getDecoration(
                        context,
                        context.colors.surfaceVariant,
                      ),
                    ),
                    AppSpacing.h4,
                    Container(
                      width: width.getPercentage(28),
                      height: height,
                      decoration: getDecoration(
                        context,
                        context.colors.surfaceVariant,
                      ),
                    ),
                    AppSpacing.h4,
                    Container(
                      width: width.getPercentage(24),
                      height: height,
                      decoration: getDecoration(
                        context,
                        context.colors.surfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration getDecoration(BuildContext context, [Color? color]) {
    return BoxDecoration(
      color: color ?? context.colors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    );
  }
}
