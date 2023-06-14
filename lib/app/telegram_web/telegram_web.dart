import 'package:appwrite_telegram/app/models/tg_popup_button.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

/// TelegramWebService file to access telegram web app features
class TelegramWeb {
  static bool get isSupported => tg.isSupported;

  static bool get isDarkMode => tg.isDarkMode;

  static double? get viewportHeight => tg.viewportHeight;

  static void showDialog({
    required String title,
    required String message,
    List<TGPopupButton>? buttons,
    Function(String buttonId)? onTap,
  }) {
    tg.TelegramPopup(
      message: message,
      title: title,
      buttons: buttons
          ?.map((TGPopupButton e) => tg.PopupButton(
                id: e.id,
                text: e.text,
                type: tg.PopupButtonType.values.firstWhere(
                    (PopupButtonType element) => element.name == e.type?.name),
              ))
          .toList(),
      onTap: onTap,
    ).show();
  }

  static void setUpListeners({
    Function()? onBackClick,
    Function(bool isDarkMode, dynamic themeParams)? onThemeChange,
    Function(bool isStable, double height, dynamic stableHeight)?
        onViewPortChange,
  }) {
    tg.BackButton.onClick(tg.JsVoidCallback(() => onBackClick?.call()));

    tg.TelegramWebEvent.setViewPortChangeListener(
        (isStable, height, stableHeight) {
      onViewPortChange?.call(isStable, height, stableHeight);
    });

    tg.TelegramWebEvent.setThemeChangeListener((isDarkMode, params) {
      onThemeChange?.call(isDarkMode, params);
    });
  }
}
