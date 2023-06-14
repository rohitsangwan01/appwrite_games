import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UI {
  static const Duration snackbarOpeningTime = Duration(seconds: 4);

  ///`Error` Message
  static void presentError(message, {Duration? duration}) =>
      UI.errorSnackBar(message: message, duration: duration)?.show();

  ///`Success` Message
  static void presentSuccess(message, {Duration? duration}) =>
      UI.successSnackBar(message: message)?.show();

  static void closeKeyboard() =>
      FocusScope.of(Get.context!).requestFocus(FocusNode());

  /// `Custom BottomSheet`
  static Future presentBottomSheet(String msg) async {
    BuildContext? context = Get.context;
    if (context == null) {
      return null;
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        content: Container(
          height: Get.height / 9,
          color: Theme.of(context).colorScheme.secondary,
          child: Center(
            child: Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static GetSnackBar? successSnackBar({
    required String message,
  }) {
    BuildContext? context = Get.context;
    if (context == null) {
      return null;
    }
    return GetSnackBar(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: snackbarOpeningTime,
    );
  }

  static GetSnackBar? errorSnackBar({
    required String message,
    Duration? duration,
  }) {
    BuildContext? context = Get.context;
    if (context == null) {
      return null;
    }
    return GetSnackBar(
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      icon: const Icon(
        Icons.remove_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: duration ?? snackbarOpeningTime,
    );
  }

  static void showLoadingBar() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Theme.of(Get.context!).colorScheme.tertiary,
        ),
      ),
    );
  }

  static void closeLoading({checkSnackbar = true}) {
    if (checkSnackbar) Get.closeAllSnackbars();
    if (Get.isDialogOpen == true) Get.back();
  }
}
