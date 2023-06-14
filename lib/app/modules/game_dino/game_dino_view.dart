import 'package:appwrite_telegram/app/modules/game_dino/widgets/dino_game_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dino_users_list.dart';
import 'game_dino_controller.dart';

class GameDinoView extends GetView<GameDinoController> {
  const GameDinoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadDinoData();
              Get.to(() => const DinoUsersList());
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: DinoGameWidget(
              onDinoStateChange: controller.onDinoStateChange,
              onScoreUpdate: controller.onScoreUpdate,
            ),
          ),
        ],
      ),
    );
  }
}
