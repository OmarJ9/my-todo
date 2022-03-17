import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/shared/styles/colors.dart';

class MySnackBar extends Flushbar {
  MySnackBar({Key? key}) : super(key: key);

  static Flushbar error(
      {required String message,
      required Color color,
      required BuildContext context}) {
    return Flushbar(
      animationDuration: const Duration(milliseconds: 1000),
      backgroundColor: color,
      duration: const Duration(milliseconds: 3000),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      messageText: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 11.sp,
                color: Appcolors.white,
              ),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
    )..show(context);
  }
}
