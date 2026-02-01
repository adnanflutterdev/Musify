import 'package:flutter/material.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text_field_borders.dart';

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
      style: TextStyle(color: AppColors.surfaceWhite),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: isObscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: filledColor,
        hintStyle: TextStyle(color: AppColors.onSurfaceLow),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        enabledBorder: outlinedBorder(
          color: AppColors.surfaceWhite,
          width: 0.7,
        ),
        focusedBorder: outlinedBorder(color: AppColors.primary, width: 1.0),
        errorBorder: errorBorder
            ? outlinedBorder(color: AppColors.error, width: 0.5)
            : null,
        errorStyle: TextStyle(color: AppColors.textFieldOnError, fontSize: 10),
        focusedErrorBorder: focusedErorBorder
            ? outlinedBorder(color: AppColors.primary, width: 1.0)
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
