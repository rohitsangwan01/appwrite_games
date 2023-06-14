import 'package:appwrite_function/bot_manager.dart';
import 'dart:convert';

void main(List<String> args) async {
  print("Starting bot...");
  await BotManager.start();
  print("Bot started!");
}

// Entry point for the function.
Future<void> start(final req, final res) async {
  try {
    var payload = req.payload;
    if (payload == null) throw 'Payload is null';
    BotManager.pushUpdate(jsonDecode(payload)['body']);
    res.json({'success': true});
  } catch (e) {
    res.json({'error': e.toString()});
  }
}
