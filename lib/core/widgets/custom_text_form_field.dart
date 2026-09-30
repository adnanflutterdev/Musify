import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text_field_borders.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onSuffixIconTapped,
    this.textInputType,
    this.textStyle,
    this.iconWidth,
    this.onChanged,
    this.focusNode,
    this.isObscure = false,
    this.isReadOnly = false,
    this.isSuffixIconLoading = false,
    this.unfocusOnTapOutside = false,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.secondaryLabel,
    this.showOptional = false,
    this.textInputAction,
    this.iconSize = 20,
    this.iconColor,
    this.disableBorder = false,
    this.validator,
    this.maxLengths,
    this.forceErrorText,
    this.header,
  });
  final String? label;
  final double iconSize;
  final Color? iconColor;
  final bool isObscure;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSuffixIconLoading;
  final VoidCallback? onSuffixIconTapped;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final double? iconWidth;
  final TextStyle? textStyle;
  final Function(String value)? onChanged;
  final Function(String? value)? onSubmitted;
  final FocusNode? focusNode;
  final bool isReadOnly;
  final bool unfocusOnTapOutside;
  final int? maxLines;
  final int? minLines;
  final int? maxLengths;
  final VoidCallback? onTap;
  final Widget? secondaryLabel;
  final bool showOptional;
  final TextInputAction? textInputAction;
  final bool disableBorder;
  final FormFieldValidator<String>? validator;
  final String? forceErrorText;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (label != null) ...[?header, AppSpacing.h4],
        if (label != null) ...[
          Row(
            children: [
              Flexible(child: Text(label!, style: context.text.bodyLarge)),
              if (showOptional)
                Flexible(
                  child: Text(
                    ' (Optional)',
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              const Spacer(),
              ?secondaryLabel,
            ],
          ),
          AppSpacing.h4,
        ],

        TextFormField(
          maxLines: maxLines,
          minLines: minLines,
          focusNode: focusNode,
          readOnly: isReadOnly,
          textInputAction: textInputAction,
          controller: controller,
          keyboardType: textInputType,
          obscureText: isObscure,
          obscuringCharacter: '●',
          style:
              textStyle ??
              context.text.bodyMedium?.copyWith(
                color: context.colors.textPrimary,
              ),
          maxLength: maxLengths,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.text.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon != null
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(prefixIcon, size: iconSize, color: iconColor),
                  )
                : null,
            suffixIcon: isSuffixIconLoading
                ? const CircularProgressIndicator()
                : suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixIconTapped,
                    icon: Icon(suffixIcon, size: iconSize, color: iconColor),
                  )
                : null,
          ),

          forceErrorText: forceErrorText,
          errorBuilder: (context, errorText) {
            return Text(
              errorText,
              style: context.text.labelMedium?.copyWith(
                color: context.colors.error,
              ),
            );
          },

          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          onTapOutside: (event) {
            if (unfocusOnTapOutside) {
              focusNode?.unfocus();
            }
          },
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isObscure = false,
    this.errorBorder = false,
    this.focusedErorBorder = false,
    this.filledColor = AppColors.surfaceVariant,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
  });
  final bool isObscure;
  final String hintText;
  final IconButton? suffixIcon;
  final bool errorBorder;
  final bool focusedErorBorder;
  final Color filledColor;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: keyboardType == TextInputType.emailAddress
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      cursorColor: AppColors.surfaceWhite,
      style: const TextStyle(color: AppColors.surfaceWhite),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: isObscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: filledColor,
        hintStyle: const TextStyle(color: AppColors.onSurfaceLow),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        enabledBorder: outlinedBorder(
          color: AppColors.surfaceWhite,
          width: 0.7,
        ),
        focusedBorder: outlinedBorder(color: AppColors.primary, width: 1.0),
        errorBorder: errorBorder
            ? outlinedBorder(color: AppColors.error, width: 0.5)
            : null,
        errorStyle: const TextStyle(
          color: AppColors.textFieldOnError,
          fontSize: 10,
        ),
        focusedErrorBorder: focusedErorBorder
            ? outlinedBorder(color: AppColors.primary, width: 1.0)
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
