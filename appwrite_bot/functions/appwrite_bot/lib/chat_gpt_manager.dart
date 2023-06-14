import 'package:openai_api/openai_api.dart';

import 'helpers.dart';

class ChatGptManager {
  static final _defaultError = "No response, try again !";
  static final OpenaiClient _client = OpenaiClient(
    config: OpenaiConfig(apiKey: Env.openAIKey!),
  );

  static Future<String> chatResponse({
    required String? userId,
    required String text,
  }) async {
    try {
      var completion = await _client.sendChatCompletion(
        ChatCompletionRequest(
          model: Model.gpt3_5Turbo,
          messages: [
            ChatMessage(
              content: text,
              role: ChatMessageRole.user,
            ),
          ],
          user: userId,
        ),
      );
      List<ChatChoice> choices = completion.choices;
      if (choices.isEmpty) return _defaultError;
      return choices.first.message?.content ?? _defaultError;
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<String?> getImageUrl({
    required String? userId,
    required String text,
  }) async {
    try {
      ImageResponse completion = await _client.createImage(
        ImageRequest(prompt: text, user: userId, responseFormat: 'url'),
      );
      List<ImageData> images = completion.data;
      if (images.isEmpty) return null;
      return images.first.url;
    } catch (e) {
      return null;
    }
  }
}
