import 'package:appwrite/models.dart';
import 'package:appwrite_telegram/app/data/app_data.dart';
import 'package:appwrite_telegram/app/models/chess_match.dart';
import 'package:appwrite_telegram/app/models/games_model.dart';
import 'package:appwrite_telegram/app/models/tg_popup_button.dart';
import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:appwrite_telegram/app/routes/app_pages.dart';
import 'package:appwrite_telegram/app/services/telegram_web_service.dart';
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
    TelegramWebService.to.showAlertDialog(
      title: "Choose Color",
      message: "Choose a color to play with",
      buttons: [
        TGPopupButton(id: "white", text: "White"),
        TGPopupButton(id: "black", text: "Black"),
      ],
      onTap: (buttonId) {
        if (buttonId == "white") {
          _openChessGame(false);
        } else {
          _openChessGame(true);
        }
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
    TelegramWebService.to.showAlertDialog(
      title: "Logout Confirmation",
      message: "Are you sure you want to logout?",
      buttons: [
        TGPopupButton(
          id: "cancel",
          text: "Cancel",
          type: TGPopupButtonType.cancel,
        ),
        TGPopupButton(
          id: "yes",
          text: "Yes",
          type: TGPopupButtonType.ok,
        ),
      ],
      onTap: (buttonId) async {
        if (buttonId == "yes") {
          Get.offAllNamed(Routes.LOGIN);
          await ApiService.to.logout();
        }
      },
    );
  }
}
