import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_snake_controller.dart';

class GameSnakeView extends GetView<GameSnakeController> {
  const GameSnakeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).disabledColor,
      appBar: AppBar(
        title: const Text('Snake'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Score: ${controller.score}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Max Score: ${controller.maxScore.value}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.snakeGame,
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: controller.moveLeft,
                      child: const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    InkWell(
                      onTap: controller.moveRight,
                      child: const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Text("Score Board"),
            Obx(() => ListView.builder(
                  itemCount: controller.usersList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(controller.usersList[index]),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
