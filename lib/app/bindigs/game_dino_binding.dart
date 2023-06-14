import 'package:get/get.dart';

import '../modules/game_dino/game_dino_controller.dart';

class GameDinoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameDinoController>(
      () => GameDinoController(),
    );
  }
}
