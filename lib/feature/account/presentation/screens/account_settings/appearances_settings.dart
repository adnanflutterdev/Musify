import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/extension/string_extention.dart';
import 'package:musify/core/model/appearance_theme.dart';
import 'package:musify/feature/account/presentation/provider/appearance_provider.dart';
import 'package:musify/core/theme/app_colors.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';

class AppearancesSettings extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<AppearancesSettings> createState() =>
      _AppearancesSettingsState();
}

class _AppearancesSettingsState extends ConsumerState<AppearancesSettings> {
  @override
  Widget build(BuildContext context) {
    final appearance = ref.watch(appearanceProvider);
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Text(
          'Appearance',
          style: context.text.displayMedium,
          textScaler: .noScaling,
        ),
      ),
      body: Column(
        crossAxisAlignment: .start,
        spacing: 30,
        children: [_buildThemeSection(appearance), _buildDisplay(appearance)],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subTitle,
    required IconData icon,
    required Widget secondChild,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        color: context.colors.surface,
        boxShadow: [AppShadow.shadowLvl1(context)],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: context.colors.primary,
                ),
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(icon, color: context.colors.white),
              ),

              AppSpacing.w12,

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: context.text.titleMedium?.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: .w500,
                      ),
                    ),
                    Text(subTitle),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.h12,
          secondChild,
        ],
      ),
    );
  }

  Widget _buildThemeSection(AppearanceTheme appearance) {
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: .start,
      children: [
        Text('Theme', style: context.text.headlineMedium),
        _buildThemeMode(appearance.themeMode),
        _buildAccentColor(appearance.accentColorIndex),
      ],
    );
  }

  Widget _buildThemeMode(ThemeMode themeMode) {
    final icon = switch (themeMode) {
      ThemeMode.system => Icons.phone_iphone_rounded,
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
    };
    return _buildSectionCard(
      title: 'Theme Mode',
      subTitle: 'Choose light, dark or system',
      icon: icon,
      secondChild: LayoutBuilder(
        builder: (context, constraints) {
          final width = (constraints.maxWidth - 10) / 3;
          return Row(
            spacing: 5,
            children: ThemeMode.values.map((mode) {
              final (icon, theme) = switch (mode) {
                ThemeMode.system => (
                  Icons.phone_iphone_rounded,
                  mode.name.capitalize,
                ),
                ThemeMode.light => (
                  Icons.light_mode_rounded,
                  mode.name.capitalize,
                ),
                ThemeMode.dark => (
                  Icons.dark_mode_rounded,
                  mode.name.capitalize,
                ),
              };
              return Material(
                color: context.colors.transparent,
                child: InkWell(
                  onTap: () {
                    ref.read(appearanceProvider.notifier).changeThemeMode(mode);
                  },
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  splashColor: context.colors.selection,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: mode == themeMode
                          ? Border.all(width: 2, color: context.colors.primary)
                          : null,

                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    ),

                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        Icon(icon, size: 40),
                        AppSpacing.h4,
                        Text(
                          theme,
                          style: context.text.titleLarge?.copyWith(
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildAccentColor(int accentColorIndex) {
    List<List<Color>> accentColors = [
      AppThemeColors.primary,
      AppThemeColors.primaryDark,
      AppThemeColors.primaryLight,
    ];
    List<String> names = ['Pink', 'Purple', 'Electric Blue', 'Cyan'];
    return _buildSectionCard(
      title: 'Accent Color',
      subTitle: 'Personalize Musify\'s colors',
      icon: Icons.color_lens_rounded,
      secondChild: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          spacing: 5,
          children: List.generate(AppThemeColors.primary.length, (index) {
            final colors = List.generate(
              accentColors.length,
              (i) => accentColors[i][index],
            );
            bool isSelected = index == accentColorIndex;
            return Material(
              color: context.colors.transparent,
              child: InkWell(
                onTap: () {
                  ref
                      .read(appearanceProvider.notifier)
                      .changeAccentColor(index);
                },
                splashColor: context.colors.selection,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: Container(
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(width: 2, color: context.colors.primary)
                        : null,

                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  padding: isSelected
                      ? const EdgeInsets.all(AppSpacing.sm)
                      : const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: isSelected ? 100 : 60,
                        decoration: BoxDecoration(
                          borderRadius: isSelected
                              ? BorderRadius.circular(AppSpacing.radiusMd)
                              : null,
                          shape: isSelected ? .rectangle : .circle,
                          gradient: LinearGradient(
                            colors: colors,
                            stops: [0, 0.33, 0.66],
                            tileMode: .decal,
                          ),
                        ),
                      ),
                      AppSpacing.h4,
                      Text(names[index], style: context.text.bodyLarge),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDisplay(AppearanceTheme appearance) {
    return Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: .start,
      children: [
        Text('Display', style: context.text.headlineMedium),
        _buildTextSize(appearance.textSize),
        // _buildAccentColor(appearance.accentColorIndex),
      ],
    );
  }

  Widget _buildTextSize(TextSize textSize) {
    // final icon = switch (themeMode) {
    //   ThemeMode.system => Icons.phone_iphone_rounded,
    //   ThemeMode.light => Icons.light_mode,
    //   ThemeMode.dark => Icons.dark_mode,
    // };
    return _buildSectionCard(
      title: 'Text size',
      subTitle: 'Improve readability',
      icon: Icons.text_fields_rounded,
      secondChild: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          spacing: 5,
          children: TextSize.values.map((size) {
            return Material(
              color: context.colors.transparent,
              child: InkWell(
                onTap: () {
                  ref.read(appearanceProvider.notifier).changeTextSize(size);
                },
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                splashColor: context.colors.selection,
                child: Container(
                  // width: width,
                  decoration: BoxDecoration(
                    border: size == textSize
                        ? Border.all(width: 2, color: context.colors.primary)
                        : null,

                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),

                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Text(
                        size.name.toUpperCase(),
                        style: context.text.displayLarge,
                      ),
                      AppSpacing.h4,
                      Text(
                        size.fullForm,
                        style: context.text.titleLarge?.copyWith(
                          fontWeight: .w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Widget _buildIconSize(int accentColorIndex) {
  //   List<List<Color>> accentColors = [
  //     AppThemeColors.primary,
  //     AppThemeColors.primaryDark,
  //     AppThemeColors.primaryLight,
  //   ];
  //   List<String> names = ['Pink', 'Purple', 'Electric Blue', 'Cyan'];
  //   return _buildSectionCard(
  //     title: 'Accent Color',
  //     subTitle: 'Personalize Musify\'s colors',
  //     icon: Icons.color_lens_rounded,
  //     secondChild: SingleChildScrollView(
  //       scrollDirection: .horizontal,
  //       child: Row(
  //         spacing: 5,
  //         children: List.generate(AppThemeColors.primary.length, (index) {
  //           final colors = List.generate(
  //             accentColors.length,
  //             (i) => accentColors[i][index],
  //           );
  //           bool isSelected = index == accentColorIndex;
  //           return Material(
  //             color: context.colors.transparent,
  //             child: InkWell(
  //               onTap: () {
  //                 ref
  //                     .read(appearanceProvider.notifier)
  //                     .changeAccentColor(index);
  //               },
  //               splashColor: context.colors.selection,
  //               borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   border: isSelected
  //                       ? Border.all(width: 2, color: context.colors.primary)
  //                       : null,
  //
  //                   borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
  //                 ),
  //                 padding: isSelected
  //                     ? const EdgeInsets.all(AppSpacing.sm)
  //                     : const EdgeInsets.symmetric(
  //                         horizontal: AppSpacing.md,
  //                         vertical: AppSpacing.sm,
  //                       ),
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       height: 60,
  //                       width: isSelected ? 100 : 60,
  //                       decoration: BoxDecoration(
  //                         borderRadius: isSelected
  //                             ? BorderRadius.circular(AppSpacing.radiusMd)
  //                             : null,
  //                         shape: isSelected ? .rectangle : .circle,
  //                         gradient: LinearGradient(
  //                           colors: colors,
  //                           stops: [0, 0.33, 0.66],
  //                           tileMode: .decal,
  //                         ),
  //                       ),
  //                     ),
  //                     AppSpacing.h4,
  //                     Text(names[index], style: context.text.bodyLarge),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }
}
