import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_telegram/app/data/ui.dart';
import 'package:appwrite_telegram/app/models/chess_match.dart';
import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:get/get.dart';
import 'package:chess/chess.dart';
import 'package:simple_chess_board/models/board_arrow.dart';
import 'package:simple_chess_board/simple_chess_board.dart';

class GameChessController extends GetxController {
  final chess = Chess.fromFEN(Chess.DEFAULT_POSITION);
  late bool blackAtBottom;
  late String roomId;
  late String userId;
  RxBool isLoading = false.obs;
  Rx<BoardArrow?> boardArrow = Rx<BoardArrow?>(null);
  RealtimeSubscription? _realtimeSubscription;

  RxBool myTurn = false.obs;

  @override
  void onInit() {
    _initialize();
    loadInitialiFen();
    _realtimeSubscription = ApiService.to.chessSubscription(roomId: roomId);
    _setupListeners();
    super.onInit();
  }

  void _initialize() {
    var args = Get.arguments;
    if (args != null && args is ChessMatch) {
      blackAtBottom = args.isBlackPiece;
      roomId = args.roomId;
      userId = args.userId;
    }
  }

  void loadInitialiFen() async {
    isLoading.value = true;
    try {
      final response = await ApiService.to.getChessRoomData(roomId: roomId);
      Get.log(response.toString());
      String? fen = response?['fen'];
      if (fen != null) {
        chess.load(fen);
      }
    } catch (e) {
      Get.log("Error: $e");
    } finally {
      isLoading.value = false;
      _updateTurn();
    }
  }

  /// Try to make a move
  Future<void> tryMakingMove({required ShortMove move}) async {
    Get.log(
        "Move: ${move.from} -> ${move.to} ${move.promotion} ,Fen: ${chess.fen}");
    var shotMove = <String, String?>{
      'from': move.from,
      'to': move.to,
      'promotion': move.promotion.match(
        (piece) => piece.name,
        () => null,
      ),
    };
    final success = chess.move(shotMove);
    if (!success) {
      UI.presentError("Invalid move");
      return;
    }
    ApiService.to.updateMove(
      roomId,
      move: jsonEncode(shotMove),
      fen: chess.fen,
    );
    boardArrow.value = BoardArrow(from: move.from, to: move.to);
    _onMove();
  }

  /// Listen to the realtime subscription and update the board
  void _setupListeners() {
    _realtimeSubscription?.stream.listen((event) {
      try {
        final move = event.payload['move'];
        Get.log("Move: $move");
        if (move == null) return;
        final shotMove = jsonDecode(move);
        // check if its a reset
        var isReset = shotMove['reset'];
        if (isReset != null && isReset) {
          chess.reset();
          boardArrow.value = null;
          return;
        }
        // make the move
        final success = chess.move(shotMove);
        if (!success) return;
        String from = shotMove['from'];
        String to = shotMove['to'];
        boardArrow.value = BoardArrow(
          from: from,
          to: to,
        );
        _onMove();
      } catch (e) {
        Get.log("Error: $e");
      }
    });
  }

  /// Reset game
  Future<void> resetGame() async {
    chess.reset();
    boardArrow.value = null;
    var shotMove = {
      'reset': true,
    };
    await ApiService.to.updateMove(
      roomId,
      move: jsonEncode(shotMove),
      fen: Chess.DEFAULT_POSITION,
    );
  }

  void _onMove() {
    // update turn
    _updateTurn();

    // Check game status
    if (chess.in_check) {
      UI.presentError("Check..");
    }
    if (chess.in_checkmate) {
      UI.presentError("Checkmate..");
    }
    if (chess.in_draw) {
      UI.presentError("Draw..");
    }
    if (chess.in_stalemate) {
      UI.presentError("Stalemate..");
    }
    if (chess.in_threefold_repetition) {
      UI.presentError("Threefold repetition..");
    }
    if (chess.insufficient_material) {
      UI.presentError("Insufficient material..");
    }
    if (chess.game_over) {
      UI.presentError("Game over..");
    }
    // Reset game if game over
    if (chess.in_checkmate || chess.in_draw || chess.in_stalemate) {
      resetGame();
    }
  }

  void _updateTurn() {
    myTurn.value = blackAtBottom == (chess.turn == Chess.BLACK);
  }

  @override
  void onClose() {
    _realtimeSubscription?.close();
    super.onClose();
  }
}
