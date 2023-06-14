import 'package:appwrite_telegram/app/models/tg_popup_button.dart';

/// TelegramWebService file to access telegram web app features
class TelegramWeb {
  static bool get isSupported => false;

  static bool get isDarkMode => false;

  static double? get viewportHeight => null;

  static void showDialog({
    required String title,
    required String message,
    List<TGPopupButton>? buttons,
    Function(String buttonId)? onTap,
  }) {}

  static void setUpListeners({
    Function()? onBackClick,
    Function(bool isDarkMode, dynamic themeParams)? onThemeChange,
    Function(bool isStable, double height, dynamic stableHeight)?
        onViewPortChange,
  }) {}
}
