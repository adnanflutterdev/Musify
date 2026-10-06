import 'package:flutter/material.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,

    this.leading,
    this.trailing,
    this.titleSpacing,
    this.trailingSpacing,
    this.backgroundColor,
    this.verticalPadding,
    this.onTap,

    this.hasLeading = true,
    this.buildAppLogo = false,
  });
  final bool hasLeading;
  final bool buildAppLogo;
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final SizedBox? titleSpacing;
  final SizedBox? trailingSpacing;
  final Color? backgroundColor;
  final void Function()? onTap;
  final SizedBox? verticalPadding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: context.colors.surface,
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            boxShadow: [
              AppShadow.shadowLvl1(context, offset: const Offset(0, 3)),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              Row(
                children: [
                  if (!hasLeading || buildAppLogo) AppSpacing.w12,
                  if (buildAppLogo) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.background,
                        shape: .circle,
                        boxShadow: [AppShadow.shadowLvl1(context)],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(AppImages.logo, height: 35),
                    ),
                    AppSpacing.w8,
                  ] else if (leading != null) ...[
                    AppSpacing.w12,
                    ?leading,
                    AppSpacing.w8,
                  ] else if (hasLeading)
                    IconButton(
                      onPressed:
                          onTap ??
                          () {
                            Navigator.pop(context);
                          },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ?titleSpacing,
                  Expanded(child: title),
                  if (trailing != null) ...[?trailingSpacing, ?trailing],
                  AppSpacing.w12,
                ],
              ),
              ?verticalPadding,
            ],
          ),
        ),
      ],
    );
  }
}
