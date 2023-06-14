// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_chess_board/simple_chess_board.dart';
import 'game_chess_controller.dart';

class GameChessView extends GetResponsiveView<GameChessController> {
  GameChessView({Key? key});

  @override
  Widget builder() {
    double size =
        (screen.isDesktop || screen.isTablet) ? Get.height / 1.5 : Get.width;
    return Scaffold(
        backgroundColor: Theme.of(Get.context!).cardColor,
        appBar: AppBar(
          title: const Text('Chess'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: controller.resetGame,
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("User : ${controller.userId}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Obx(() => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SimpleChessBoard(
                          engineThinking: false,
                          fen: controller.chess.fen,
                          showCoordinatesZone: true,
                          onMove: controller.tryMakingMove,
                          orientation: controller.blackAtBottom
                              ? BoardColor.black
                              : BoardColor.white,
                          whitePlayerType: controller.blackAtBottom
                              ? PlayerType.computer
                              : PlayerType.human,
                          blackPlayerType: controller.blackAtBottom
                              ? PlayerType.human
                              : PlayerType.computer,
                          lastMoveToHighlight: controller.boardArrow.value,
                          onPromote: () async => PieceType.queen,
                          chessBoardColors: ChessBoardColors(),
                        )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Card(
                      color: controller.myTurn.value
                          ? Theme.of(Get.context!).primaryColor
                          : Theme.of(Get.context!).colorScheme.onBackground,
                      child: ListTile(
                        title: Text(
                          controller.myTurn.value
                              ? "Your Turn"
                              : "Waiting for opponent response",
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
