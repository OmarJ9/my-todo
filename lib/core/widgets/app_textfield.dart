import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../theme/app_styles.dart';

class AppTextfield extends StatelessWidget {
  final IconData? suffixIcon;
  final bool? obscureText;
  final String hint;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final int? maxLength;
  final FocusNode? focusNode;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final VoidCallback? onSuffixIconTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? filledColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? verticalPadding;
  final String? errorText;
  final String? initialValue;

  const AppTextfield({
    super.key,
    required this.hint,
    this.validator,
    this.focusNode,
    this.obscureText = false,
    this.textEditingController,
    this.maxLength,
    this.onChange,
    this.onSubmit,
    this.onTapOutside,
    this.onSuffixIconTap,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.filledColor,
    this.textColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.verticalPadding,
    this.errorText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      textCapitalization: TextCapitalization.none,
      maxLines: 1,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textEditingController,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTapOutside: onTapOutside,
      obscureText: obscureText!,
      onTap: readOnly ? onTap : null,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.medium14(color: Colors.grey.shade500),
        fillColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: verticalPadding != null ? verticalPadding!.h : 15.h,
        ),
        errorText: errorText,
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: prefixIconColor ?? context.theme.primaryColor,
              ),
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: onSuffixIconTap,
                icon: Icon(
                  suffixIcon!,
                  color: context.theme.primaryColor,
                ),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: context.theme.primaryColor,
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: AppTypography.medium14(),
      cursorColor: context.theme.primaryColor,
      initialValue: initialValue,
    );
  }
}
