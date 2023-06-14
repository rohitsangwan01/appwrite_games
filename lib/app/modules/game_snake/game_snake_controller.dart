import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:appwrite_telegram/app/data/ui.dart';
import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/flutter_snake.dart';
import 'package:get/get.dart';

class GameSnakeController extends GetxController {
  late SnakeGame snakeGame;
  StreamSubscription? _gameEventSubscription;
  final _gameEventController = StreamController<GAME_EVENT>();

  String? userId;
  RxList<String> usersList = <String>[].obs;

  RxInt score = 0.obs;
  RxString maxScore = "".obs;

  @override
  void onInit() {
    _gameEventSubscription =
        _gameEventController.stream.listen((GAME_EVENT value) {
      switch (value) {
        case GAME_EVENT.win:
          _onGameComplete();
          showDialog("You win", "You win");
          break;
        case GAME_EVENT.out_of_map:
          _onGameComplete();
          showDialog("You lose", "Hit Border");
          break;
        case GAME_EVENT.hit_his_tail:
          _onGameComplete();
          showDialog("You loose", "Hit Tail");
          break;
        case GAME_EVENT.food_eaten:
          score.value++;
          break;
      }
    });
    _setupGame();
    _loadSnakeData();
    super.onInit();
  }

  void _onGameComplete() async {
    try {
      await ApiService.to.setSnakeMaxScore(score.value);
    } catch (e) {
      UI.presentError(e.toString());
    }
  }

  void _loadSnakeData() async {
    try {
      _loadAllUsersData();
      Document? document = await ApiService.to.getSnakeDocument();
      if (document == null) return;
      maxScore.value = document.data['max_score']?.toString() ?? "";
    } catch (e) {
      UI.presentError(e.toString());
    }
  }

  void _loadAllUsersData() async {
    try {
      List<Document> documentList =
          await ApiService.to.getSnakeDocumentsOfAllUsers();
      documentList.sort((a, b) {
        int aScore = a.data['max_score'] ?? 0;
        int bScore = b.data['max_score'] ?? 0;
        return bScore.compareTo(aScore);
      });
      usersList.value = documentList
          .map((e) => "${e.data['max_score'] ?? 0} - ${e.data['user_id']}")
          .toList();
    } catch (e) {
      UI.presentError(e.toString());
    }
  }

  void _setupGame() {
    int numberCaseHorizontally = 11;
    double caseWidth = (Get.width > Get.height)
        ? (Get.height / (numberCaseHorizontally * 2))
        : Get.width / (numberCaseHorizontally * 1.2);

    snakeGame = SnakeGame(
      caseWidth: caseWidth,
      numberCaseHorizontally: numberCaseHorizontally,
      numberCaseVertically: numberCaseHorizontally,
      controllerEvent: _gameEventController,
      durationBetweenTicks: const Duration(milliseconds: 400),
    );
  }

  void moveLeft() => snakeGame.nextDirection = SNAKE_MOVE.left;
  void moveRight() => snakeGame.nextDirection = SNAKE_MOVE.right;
  void moveFront() => snakeGame.nextDirection = SNAKE_MOVE.front;

  void showDialog(
    String title,
    String content,
  ) {
    Get.defaultDialog(
      backgroundColor: Theme.of(Get.context!).cardColor,
      title: title,
      content: Text(content),
    );
  }

  @override
  void dispose() {
    _gameEventSubscription?.cancel();
    _gameEventController.close();
    super.dispose();
  }
}
