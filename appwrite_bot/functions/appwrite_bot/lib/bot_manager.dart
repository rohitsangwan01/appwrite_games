import 'package:appwrite_function/appwrite_manager.dart';
import 'package:appwrite_function/chat_gpt_manager.dart';
import 'package:appwrite_function/helpers.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class BotManager {
  static Bot? bot;

  // Handle bot setup.
  static void _setupBot() {
    bot = Bot(Env.botToke!);

    bot?.command('start', (ctx) async {
      ctx.reply(_introMessage(ctx.chat.firstName, isStartCommand: true));
    });

    bot?.command('help', (ctx) async {
      ctx.reply(
        _helpMessage(),
        disableWebPagePreview: true,
      );
    });

    bot?.command('games', (ctx) async {
      ctx.reply(
        "To play games click on button in left of text box\nGames are built using Flutter and using appwrite as backend\n\n"
        "Available games:\n\n"
        "1. Chess\n"
        "2. Snake\n"
        "3. Dino\n"
        "More games coming soon\n\n"
        "To play games in browser: https://rohitsangwan01.github.io/appwrite_games_web/ \n"
        "Also you can build Mobile and desktop apps from this repo : https://github.com/rohitsangwan01/appwrite_games_web",
        disableWebPagePreview: true,
      );
    });

    bot?.command('chat', (ctx) async {
      String? commandText = ctx.message.commandMessage;
      if (commandText == null || commandText.isEmpty) {
        await ctx
            .reply('Please enter a message to send to the bot. e.g /chat hi');
        return;
      }
      Message msg = await ctx.reply('Please wait...');
      String response = await ChatGptManager.chatResponse(
        userId: ctx.chat.id.toString(),
        text: commandText,
      );
      await msg.update(response);
    });

    bot?.command('image', (ctx) async {
      String? commandText = ctx.message.commandMessage;
      if (commandText == null || commandText.isEmpty) {
        await ctx.reply(
            'Please enter a message to send to the bot. e.g /image flying bird');
        return;
      }
      await ctx.reply('Please wait...');

      String? imageUrl = await ChatGptManager.getImageUrl(
        userId: ctx.chat.id.toString(),
        text: commandText,
      );
      if (imageUrl == null) {
        await ctx.reply('No image found');
      } else {
        await ctx.replyWithPhoto(
          InputFile.fromUrl(imageUrl),
          replyToMessageId: ctx.message.messageId,
        );
      }
    });

    /// Games
    bot?.command('snakeScoreBoard', (ctx) async {
      Message msg = await ctx.reply('Please wait...');
      List<String> scoreBoard = await AppwriteManager.getSnakeScoreBoard();
      String text = "Snake Score Board:\n\n";
      for (int i = 0; i < scoreBoard.length; i++) {
        text += "${i + 1}. ${scoreBoard[i]}\n";
      }
      msg.update(text);
    });

    bot?.command('dinoScoreBoard', (ctx) async {
      Message msg = await ctx.reply('Please wait...');
      List<String> scoreBoard = await AppwriteManager.getDinoScoreBoard();
      String text = "Dino Score Board:\n\n";
      for (int i = 0; i < scoreBoard.length; i++) {
        text += "${i + 1}. ${scoreBoard[i]}\n";
      }
      msg.update(text);
    });

    // receive all messages here
    bot?.onMessage((ctx) async {
      ctx.reply(
        _introMessage(ctx.from?.firstName),
        disableWebPagePreview: true,
      );
    });
  }

  static String _introMessage(String? name, {bool isStartCommand = false}) {
    var initialText =
        "${isStartCommand ? "Welcome" : "Hey"}${name == null ? "!" : ", $name!"} ☺️\n";
    var shortIntro =
        "You can use this bot to /chat with openAi\nor play /games with friends by using games button,\nUse /help to see all the commands.";
    return '$initialText\n$shortIntro.\n\n$appWriteInfo';
  }

  static String appWriteInfo =
      "This bot is powered by appwrite : https://appwrite.io/";

  static String _helpMessage() {
    return "You can use these commands to interact with the bot:\n\n"
        "/start - Start the bot\n"
        "/help - Show this help message\n"
        "/chat - Chat with the bot using openAI\n"
        "/image - Get an image from the bot usinh openAI\n"
        "\nYou can play /games with this bot by tapping on games button\n\n"
        "/snakeScoreBoard - Get score board for snake game\n"
        "/dinoScoreBoard - Get score board for dino game\n"
        "\n\n$appWriteInfo";
  }

  // To test locally start bot with this function.
  static start() async {
    if (bot == null) _setupBot();
    await bot?.start();
  }

  // This will be called from the function.
  static void pushUpdate(payloadBody) async {
    if (bot == null) _setupBot();
    if (payloadBody == null) throw 'Payload is null';
    bot?.handleUpdate(Update.fromJson(payloadBody));
  }
}
