import 'package:appwrite_function/helpers.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

class AppwriteManager {
  static final Client _client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject(Env.appwriteProjectId)
      .setKey(Env.appwriteKey);
  static Databases get _databases => Databases(_client);

  static final _gamesDatabase = "6487589c648d290b826b";
  static final _snakeCollection = "6488b0ef8bf44ba85854";
  static final _dinoCollection = "6488c978c716d59d94cc";
  // static final _chessCollection = "648758a180b5e3a59ce0";

  static Future<List<String>> getDinoScoreBoard() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _gamesDatabase,
        collectionId: _dinoCollection,
      );
      List<Document> documentList = response.documents;
      documentList.sort((a, b) {
        int aScore = a.data['max_score'] ?? 0;
        int bScore = b.data['max_score'] ?? 0;
        return bScore.compareTo(aScore);
      });
      return documentList
          .map((e) => "${e.data['max_score'] ?? 0} - ${e.data['user_id']}")
          .toList();
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  static Future<List<String>> getSnakeScoreBoard() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _gamesDatabase,
        collectionId: _snakeCollection,
      );
      List<Document> documentList = response.documents;
      documentList.sort((a, b) {
        int aScore = a.data['max_score'] ?? 0;
        int bScore = b.data['max_score'] ?? 0;
        return bScore.compareTo(aScore);
      });
      return documentList
          .map((e) => "${e.data['max_score'] ?? 0} - ${e.data['user_id']}")
          .toList();
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }
}
