import 'dart:io';

import 'package:appwrite_function/bot_manager.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class Env {
  static String? botToke = Platform.environment['BOT_TOKEN'];
  static String? openAIKey = Platform.environment['OPENAI_KEY'];
  static String? appwriteProjectId =
      Platform.environment['APPWRITE_PROJECT_ID'];
  static String? appwriteKey = Platform.environment['APPWRITE_KEY'];
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
