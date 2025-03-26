import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class AppTextfield extends StatelessWidget {
  final IconData icon;
  final String hint;
  final FormFieldValidator<String> validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardtype;
  final bool obscure;
  final bool readonly;
  final bool showicon;
  final int? maxlenght;
  final Function()? ontap;
  final Function(String)? onChanged;

  const AppTextfield({
    super.key,
    required this.hint,
    required this.icon,
    required this.validator,
    required this.textEditingController,
    this.obscure = false,
    this.readonly = false,
    this.showicon = true,
    this.ontap,
    this.keyboardtype = TextInputType.text,
    this.maxlenght,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      maxLength: maxlenght,
      readOnly: readonly,
      obscureText: obscure,
      keyboardType: keyboardtype,
      onTap: readonly ? ontap : null,
      onChanged: onChanged,
      controller: textEditingController,
      style: AppTypography.medium14(),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 0,
              )),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          hintStyle:
              AppTypography.medium14().copyWith(color: Colors.deepPurple),
          prefixIcon: showicon
              ? Icon(
                  icon,
                  size: 22,
                  color: Colors.deepPurple,
                )
              : null,
          suffixIcon: readonly
              ? Icon(
                  icon,
                  size: 22,
                  color: Colors.deepPurple,
                )
              : null),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
