import 'package:appwrite/models.dart';
import 'package:appwrite_telegram/app/data/ui.dart';
import 'package:appwrite_telegram/app/modules/game_dino/widgets/dino.dart';
import 'package:appwrite_telegram/app/services/api_service.dart';
import 'package:get/get.dart';

class GameDinoController extends GetxController {
  int score = 0;
  RxList<String> usersList = <String>[].obs;
  RxString maxScore = "".obs;

  @override
  void onInit() {
    loadDinoData();
    super.onInit();
  }

  void onDinoStateChange(DinoState state) {
    if (state == DinoState.dead && score > 0) {
      _onGameComplete();
    }
  }

  void onScoreUpdate(int score, int hightScore) async {
    this.score = score;
  }

  void _onGameComplete() async {
    try {
      await ApiService.to.setDinoMaxScore(score);
    } catch (e) {
      UI.presentError(e.toString());
    }
  }

  void loadDinoData() async {
    try {
      _loadAllUsersData();
      Document? document = await ApiService.to.getDinoDocument();
      if (document == null) return;
      maxScore.value = document.data['max_score']?.toString() ?? "";
    } catch (e) {
      UI.presentError(e.toString());
    }
  }

  void _loadAllUsersData() async {
    try {
      List<Document> documentList =
          await ApiService.to.getDinoDocumentsOfAllUsers();
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
}
