import 'package:get/get.dart';

import '../bindigs/game_chess_binding.dart';
import '../bindigs/game_snake_binding.dart';
import '../bindigs/home_binding.dart';
import '../bindigs/login_binding.dart';
import '../modules/game_chess/game_chess_view.dart';
import '../bindigs/game_dino_binding.dart';
import '../modules/game_dino/game_dino_view.dart';
import '../modules/game_snake/game_snake_view.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.GAME_CHESS,
      page: () => GameChessView(),
      binding: GameChessBinding(),
    ),
    GetPage(
      name: _Paths.GAME_SNAKE,
      page: () => GameSnakeView(),
      binding: GameSnakeBinding(),
    ),
    GetPage(
      name: _Paths.GAME_DINO,
      page: () => const GameDinoView(),
      binding: GameDinoBinding(),
    ),
  ];
}
