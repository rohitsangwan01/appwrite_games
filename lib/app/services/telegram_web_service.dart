// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:get/get.dart';

/// TelegramWebService file to access telegram web app features
class TelegramWebService extends GetxService {
  static TelegramWebService get to => Get.find();

  // RxDouble viewPortHeight = 0.0.obs;
  // RxBool isViewPortHeightChanging = false.obs;
  // bool _isDarkMode = false;

  Future<TelegramWebService> init() async {
    // viewPortHeight.value = tg.viewportHeight ?? 0.0;
    // _isDarkMode = tg.isDarkMode;
    _setUpListeners();
    return this;
  }

  void _setUpListeners() {
    // tg.BackButton.onClick(JsVoidCallback(() => Get.back()));

    // TelegramWebEvent.setViewPortChangeListener(
    //     (isStable, height, stableHeight) {
    //   viewPortHeight.value = height;
    //   isViewPortHeightChanging.value = !isStable;
    // });

    // TelegramWebEvent.setThemeChangeListener((isDarkMode, params) {
    //   Change theme when changed in telgram
    // });
  }
}
