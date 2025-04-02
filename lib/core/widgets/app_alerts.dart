import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Alerts {
  final BuildContext context;

  Alerts.of(this.context);

  void showError(String message) {
    // top of the screen
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 180.h,
          ),
          content: AwesomeSnackbarContent(
            title: "Something went wrong!",
            message: message,
            contentType: ContentType.failure,
          ),
        ),
      );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 180.h,
          ),
          content: AwesomeSnackbarContent(
            title: "Congratulations!",
            message: message,
            contentType: ContentType.success,
          ),
        ),
      );
  }

  void showWarning(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 180.h,
          ),
          content: AwesomeSnackbarContent(
            title: "Warning!",
            message: message,
            contentType: ContentType.warning,
          ),
        ),
      );
  }
}
