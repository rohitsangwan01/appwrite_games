import 'package:appwrite_telegram/app/models/tg_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite_telegram/app/telegram_web/telegram_web_unsupported.dart'
    if (dart.library.html) 'package:appwrite_telegram/app/telegram_web/telegram_web.dart';

/// TelegramWebService file to access telegram web app features
class TelegramWebService extends GetxService {
  static TelegramWebService get to => Get.find();
  bool get isSupported => TelegramWeb.isSupported;
  bool get isDarkMode => TelegramWeb.isDarkMode;

  RxDouble viewPortHeight = 0.0.obs;
  RxBool isViewPortHeightChanging = false.obs;

  Future<TelegramWebService> init() async {
    viewPortHeight.value = TelegramWeb.viewportHeight ?? 0.0;
    _setUpListeners();
    return this;
  }

  // This method will automaticall show either TelegramDialog or flutter dialog based on platform
  void showAlertDialog({
    required String title,
    required String message,
    BuildContext? context,
    List<TGPopupButton>? buttons,
    Function(String buttonId)? onTap,
  }) async {
    //Use normal dialog for now
    // if (isSupported) {
    //   TelegramWeb.showDialog(
    //     title: title,
    //     message: message,
    //     buttons: buttons,
    //     onTap: onTap,
    //   );
    // return;
    // }
    showDialog<void>(
      context: context ?? Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          backgroundColor: Theme.of(context).cardColor,
          content: Text(message),
          actions: buttons
              ?.map((e) => TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onTap?.call(e.id);
                  },
                  child: Text(e.text ?? "")))
              .toList(),
        );
      },
    );
  }

  void _setUpListeners() {
    TelegramWeb.setUpListeners(
      onBackClick: () => null,
      onThemeChange: (isDarkMode, themeParams) {
        Get.log("DarkMode : $isDarkMode");
      },
      onViewPortChange: (isStable, height, stableHeight) {
        viewPortHeight.value = height;
        isViewPortHeightChanging.value = !isStable;
      },
    );
  }
}
