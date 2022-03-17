import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/shared/styles/colors.dart';

class MyTextfield extends StatelessWidget {
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
  const MyTextfield(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.validator,
      required this.textEditingController,
      this.obscure = false,
      this.readonly = false,
      this.showicon = true,
      this.ontap,
      this.keyboardtype = TextInputType.text,
      this.maxlenght = null})
      : super(key: key);

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
      controller: textEditingController,
      style: Theme.of(context).textTheme.headline1?.copyWith(
            fontSize: 9.sp,
            color: Appcolors.black,
          ),
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
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.3.h),
          hintStyle: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 9.sp,
                color: Colors.deepPurple,
              ),
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
