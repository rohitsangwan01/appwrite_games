import 'package:appwrite_telegram/app/modules/game_dino/game_dino_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DinoUsersList extends GetView<GameDinoController> {
  const DinoUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino Score Board'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("Your Max Score: ${controller.maxScore}"),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.usersList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(controller.usersList[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
