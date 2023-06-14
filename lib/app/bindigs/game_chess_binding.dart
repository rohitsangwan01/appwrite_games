import 'package:get/get.dart';

import '../modules/game_chess/game_chess_controller.dart';

class GameChessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameChessController>(
      () => GameChessController(),
    );
  }
}
