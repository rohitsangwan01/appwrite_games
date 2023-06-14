// ignore_for_file: use_key_in_widget_constructors

import 'package:appwrite_telegram/app/models/games_model.dart';
import 'package:appwrite_telegram/app/modules/home/app_drawer.dart';
import 'package:appwrite_telegram/app/modules/home/home_controller.dart';
import 'package:appwrite_telegram/appwrite_theme_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key});

  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).cardColor,
      appBar: AppBar(
        title: const Text('Appwrite Games'),
        centerTitle: true,
        actions: const [LogoutButton()],
      ),
      drawer: screen.isPhone ? const AppDrawer() : null,
      body: Row(
        children: [
          screen.isPhone
              ? const SizedBox()
              : screen.isTablet
                  ? AppDrawer(width: Get.width / 4)
                  : const AppDrawer(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screen.isPhone
                            ? 2
                            : screen.isTablet
                                ? 4
                                : 6,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: controller.games.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GamesWidget(game: controller.games[index]);
                      },
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutButton extends GetView<HomeController> {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.logout(context),
      icon: const Icon(Icons.logout),
    );
  }
}

class GamesWidget extends StatelessWidget {
  final GamesModel game;
  const GamesWidget({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => game.onTap?.call(context),
      child: Card(
        color: AppwriteColors.colorNeutral300,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: game.image == null
            ? Center(
                child: Text(game.name),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  game.image!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
