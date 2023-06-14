import 'package:appwrite_telegram/app/modules/home/home_controller.dart';
import 'package:appwrite_telegram/app/routes/app_pages.dart';
import 'package:appwrite_telegram/appwrite_theme_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  final double? width;
  const AppDrawer({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppwriteColors.colorNeutral500,
      width: width,
      child: Column(
        children: [
          DrawerHeader(child: Image.asset('assets/icon.png')),
          Card(
            color: AppwriteColors.colorBorder,
            child: ListTile(
              title: const Text("Chess"),
              onTap: () => HomeController.to.onChessGameTap(context),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Snake"),
              onTap: () {
                Get.toNamed(Routes.GAME_SNAKE);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Dino"),
              onTap: () {
                Get.toNamed(Routes.GAME_DINO);
              },
            ),
          ),
          Card(
            color: AppwriteColors.colorDanger100,
            child: ListTile(
              title: const Text("Logout"),
              onTap: () {
                HomeController.to.logout(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
