import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  final BuildContext context;

  SnackBarHelper(this.context);

  void showFailureSnackBar(String errorTitle, String errorMessage) {
    var snackBar = SnackBar(
      duration: Duration(seconds: 3),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: errorTitle,
        message: errorMessage,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(String successTitle, String successMessage) {
    var snackBar = SnackBar(
      duration: Duration(seconds: 2),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: successTitle,
        message: successMessage,
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmailErrorSnackBar() {
    var snackBar = const SnackBar(
      duration: Duration(seconds: 1),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Email already in use!',
        message:
        'This email has been used by a different user. Please use a different mail!',
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
