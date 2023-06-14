import 'package:appwrite/models.dart';
import 'package:appwrite_telegram/app/data/app_data.dart';
import 'package:appwrite_telegram/app/models/chess_match.dart';
import 'package:appwrite_telegram/app/models/games_model.dart';
import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:appwrite_telegram/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  List<GamesModel> get games => [
        GamesModel(
          name: "Chess",
          image: 'assets/games/chess.jpg',
          onTap: onChessGameTap,
        ),
        GamesModel(
          name: "Snake",
          image: 'assets/games/snake.png',
          onTap: (context) {
            Get.toNamed(Routes.GAME_SNAKE);
          },
        ),
        GamesModel(
          name: "Dino",
          image: 'assets/games/dino.png',
          onTap: (context) {
            Get.toNamed(Routes.GAME_DINO);
          },
        ),
        GamesModel(
          name: "More Coming Soon...",
          image: null,
        ),
      ];

  void onChessGameTap(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Color"),
          backgroundColor: Theme.of(context).primaryColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                child: ListTile(
                  tileColor: Colors.white,
                  title: const Text(
                    "White",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    _openChessGame(false);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  title: const Text("Black"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _openChessGame(true);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openChessGame(bool isBlackPiece) async {
    Session? session = await ApiService.to.session;
    Get.toNamed(
      Routes.GAME_CHESS,
      arguments: ChessMatch(
        roomId: AppData.testRoomId,
        isBlackPiece: isBlackPiece,
        userId: session?.userId ?? "",
      ),
    );
  }

  void logout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          backgroundColor: Theme.of(context).cardColor,
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ApiService.to.logout();
                Get.offAllNamed(Routes.LOGIN);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
