import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

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
    this.prefixIconSize = 20,
    this.suffixIconSize = 20,
    this.iconColor,
    this.disableBorder = false,
    this.validator,
    this.maxLengths,
    this.forceErrorText,
    this.header,
    this.contentPadding,
  });
  final String? label;
  final double prefixIconSize;
  final double suffixIconSize;
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
  final EdgeInsets? contentPadding;

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
              AppSpacing.w12,
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
            prefixIconConstraints: prefixIcon != null
                ? const BoxConstraints(minWidth: 40)
                : null,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),

            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: prefixIconSize, color: iconColor)
                : null,
            suffixIcon: isSuffixIconLoading
                ? const CircularProgressIndicator()
                : suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixIconTapped,
                    icon: Icon(
                      suffixIcon,
                      size: suffixIconSize,
                      color: iconColor,
                    ),
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