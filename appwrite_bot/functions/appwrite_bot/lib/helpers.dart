import 'dart:io';

import 'package:appwrite_function/bot_manager.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

import 'local_env.dart';

// Add or remove these LocalEnv ,
// LocalEnv is just for testing locally
class Env {
  static String? botToke =
      Platform.environment['BOT_TOKEN'] ?? LocalEnv.botToken;
  static String? openAIKey =
      Platform.environment['OPENAI_KEY'] ?? LocalEnv.openaiKey;
  static String? appwriteProjectId =
      Platform.environment['APPWRITE_PROJECT_ID'] ?? LocalEnv.appwriteProjectId;
  static String? appwriteKey =
      Platform.environment['APPWRITE_KEY'] ?? LocalEnv.appwriteKey;
}

extension UpdateExtension on Message {
  String? get commandMessage {
    if (!isCommand) return null;
    String commandName = getEntityText(MessageEntityType.botCommand)!;
    return text?.replaceFirst('/$commandName', "").trim();
  }

  Future<Message?> update(String text) async {
    try {
      return await BotManager.bot?.api.editMessageText(
        ID.create(chat.id),
        messageId,
        text,
      );
    } catch (_) {
      return null;
    }
  }
}
