import 'package:get/get.dart';

import '../modules/game_snake/game_snake_controller.dart';

class GameSnakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameSnakeController>(
      () => GameSnakeController(),
    );
  }
}
