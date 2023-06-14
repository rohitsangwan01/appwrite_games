import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:appwrite_telegram/app/routes/app_pages.dart';
import 'package:appwrite_telegram/app/services/storage_service.dart';
import 'package:appwrite_telegram/app/services/telegram_web_service.dart';
import 'package:appwrite_telegram/appwrite_theme_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

import 'package:get/get.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => ApiService().init());
  await Get.putAsync(() => TelegramWebService().init());
}

void main() async {
  await initialize();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Initialize GetMaterialApp here , because of some
    /// initial config issues with TelegramWebApp
    return GetMaterialApp(
      title: "Appwrite Telegram",
      debugShowCheckedModeBanner: false,
      initialRoute: ApiService.to.isLogged ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
      theme: AppwriteThemeFlutter.dark,
    );
  }
}
