import 'package:flutter/material.dart';
import 'package:sample_app/src/constants/app_constants.dart';

/// screen height
screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// screen width
screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// navigate to next page
navigateTo(BuildContext context, Widget route) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => route));
}

/// pop out page
pop(BuildContext context) {
  Navigator.of(context).pop();
}


/// error snack bar with custom message
showErrorSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.errorRed,
    ));

/// common snack bar with custom messages
showCommonSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.grey,
    ));


/// success snack bar with custom message
showSuccessSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.successGreen,
    ));


/// error handling method
handleApiError(context, int statusCode) {
  bool success = false;
  switch (statusCode) {
    case 200:
      success = true;
      break;
    case 201:
      success = true;
      break;
    case 400:
      // Navigator.of(context).pop();
      showErrorSnackBar(context, "Bad request format");
      success = false;
      break;
    case 404:
      // Navigator.of(context).pop();
      showErrorSnackBar(context, "Page not found");
      success = false;
      break;
    case 401:
      // Navigator.of(context).pop();
      showErrorSnackBar(context, "Authentication Error");
      success = false;
      break;
    case 500:
      // Navigator.of(context).pop();
      showErrorSnackBar(context, "Internal server error");
      success = false;
  }
  return success;
}
