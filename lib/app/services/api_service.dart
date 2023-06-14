import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite_telegram/app/services/storage_service.dart';
import 'package:appwrite_telegram/env/env.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  static ApiService get to => Get.find();
  late Client _client;
  late Realtime _realtime;
  late Databases _databases;
  late Account _account;

  final _gamesDatabase = "6487589c648d290b826b";
  final _chessCollection = "648758a180b5e3a59ce0";
  final _snakeCollection = "6488b0ef8bf44ba85854";
  final _dinoCollection = "6488c978c716d59d94cc";

  Future<ApiService> init() async {
    _client = Client();
    _client.setEndpoint(Env.endPoint).setProject(Env.projectId);
    _realtime = Realtime(_client);
    _databases = Databases(_client);
    _account = Account(_client);
    return this;
  }

  /// Auth
  ///
  bool get isLogged => StorageService.to.userId != null;

  Future<models.Session?> get session async {
    models.SessionList sessionList = await _account.listSessions();
    if (sessionList.total > 0) {
      return sessionList.sessions.first;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    try {
      models.Session session =
          await _account.createEmailSession(email: email, password: password);
      StorageService.to.userId = session.userId;
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  Future<void> signUp(String userId, String email, String password) async {
    try {
      await _account.create(userId: userId, email: email, password: password);
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  Future<void> logout() async {
    try {
      StorageService.to.userId = null;
      models.SessionList sessionList = await _account.listSessions();
      List<models.Session> sessions = sessionList.sessions;
      for (models.Session session in sessions) {
        await _account.deleteSession(sessionId: session.$id);
      }
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  /// Chess
  ///
  RealtimeSubscription chessSubscription({required String roomId}) =>
      _realtime.subscribe([
        'databases.$_gamesDatabase.collections.$_chessCollection.documents.$roomId'
      ]);

  Future<void> updateMove(
    String roomId, {
    String? move,
    String? fen,
  }) async {
    var data = {};
    if (move != null) {
      data['move'] = move;
    }
    if (fen != null) {
      data['fen'] = fen;
    }
    await _databases.updateDocument(
      databaseId: _gamesDatabase,
      collectionId: _chessCollection,
      documentId: roomId,
      data: data,
    );
  }

  Future<Map<String, dynamic>?> getChessRoomData({
    required String roomId,
  }) async {
    try {
      final response = await _databases.getDocument(
        databaseId: _gamesDatabase,
        collectionId: _chessCollection,
        documentId: roomId,
      );
      return response.data;
    } on AppwriteException catch (e) {
      Get.log(e.message.toString());
      return null;
    }
  }

  void getChessRooms() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _gamesDatabase,
        collectionId: _chessCollection,
      );
      Get.log(response.toString());
    } on AppwriteException catch (e) {
      Get.log(e.message.toString());
    }
  }

  /// Snake
  ///
  Future<List<models.Document>> getSnakeDocumentsOfAllUsers() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _gamesDatabase,
        collectionId: _snakeCollection,
      );
      return response.documents;
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  Future<models.Document?> getSnakeDocument() async {
    try {
      String? userId = StorageService.to.userId;
      if (userId == null) throw Exception('User not logged');
      final response = await _databases.listDocuments(
          databaseId: _gamesDatabase,
          collectionId: _snakeCollection,
          queries: [Query.equal('user_id', userId)]);
      List<models.Document> documents = response.documents;
      if (documents.isEmpty) return null;
      return documents.first;
    } catch (e) {
      Get.log(e.toString());
      return null;
    }
  }

  Future setSnakeMaxScore(int score) async {
    try {
      String? userId = StorageService.to.userId;
      if (userId == null) throw Exception('User not logged');
      models.Document? document = await getSnakeDocument();
      if (document == null) {
        await _databases.createDocument(
          databaseId: _gamesDatabase,
          collectionId: _snakeCollection,
          documentId: ID.unique(),
          data: {
            'user_id': userId,
            'max_score': score,
          },
        );
      } else {
        int currentScore = document.data['max_score'];
        if (score <= currentScore) {
          Get.log('$score is lower than current maxScore $currentScore');
          return;
        }
        await _databases.updateDocument(
          databaseId: _gamesDatabase,
          collectionId: _snakeCollection,
          documentId: document.$id,
          data: {
            'max_score': score,
          },
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /// Dino
  ///
  Future<List<models.Document>> getDinoDocumentsOfAllUsers() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: _gamesDatabase,
        collectionId: _dinoCollection,
      );
      return response.documents;
    } on AppwriteException catch (e) {
      throw e.message ?? e.toString();
    }
  }

  Future<models.Document?> getDinoDocument() async {
    try {
      String? userId = StorageService.to.userId;
      if (userId == null) throw Exception('User not logged');
      final response = await _databases.listDocuments(
          databaseId: _gamesDatabase,
          collectionId: _dinoCollection,
          queries: [Query.equal('user_id', userId)]);
      List<models.Document> documents = response.documents;
      if (documents.isEmpty) return null;
      return documents.first;
    } catch (e) {
      Get.log(e.toString());
      return null;
    }
  }

  Future setDinoMaxScore(int score) async {
    try {
      String? userId = StorageService.to.userId;
      if (userId == null) throw Exception('User not logged');
      models.Document? document = await getDinoDocument();
      if (document == null) {
        await _databases.createDocument(
          databaseId: _gamesDatabase,
          collectionId: _dinoCollection,
          documentId: ID.unique(),
          data: {
            'user_id': userId,
            'max_score': score,
          },
        );
      } else {
        int currentScore = document.data['max_score'];
        if (score <= currentScore) {
          Get.log('$score is lower than current maxScore $currentScore');
          return;
        }
        await _databases.updateDocument(
          databaseId: _gamesDatabase,
          collectionId: _dinoCollection,
          documentId: document.$id,
          data: {
            'max_score': score,
          },
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
