import 'package:flutter/material.dart';
import 'learn/menu.dart';
import 'pages/game.dart';
import 'player/player_page.dart'; // 音频播放器演示

void main() {
  runApp(const MyAppPlus());
}

class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class MyAppPlus extends StatelessWidget {
  const MyAppPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true, // 全局标题居中
          iconTheme: IconThemeData(
            // 这会影响返回按钮等图标
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.center,
            child: Text('flutter 学习'),
          ),
        ),
        // body 显示哪个页面,决定你看到什么。
        //
        //   当前: 音频播放器演示
        // body: const AudioPlayerPage(),
        //
        //   想看知识菜单,把 body 换回这一行:
        body: KnowledgeMenu(),
        //
        //   想看 Birdle 猜词游戏时,把 body 换回这一行:
        //        body: Center(child: GamePageState()),
        //   然后热重载(在终端按 r)即可。
      ),
    );
  }
}

class GamePageState extends StatefulWidget {
  const GamePageState({super.key});

  @override
  State<GamePageState> createState() => _GamePageStateFull();
}

class _GamePageStateFull extends State<GamePageState> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.5,
                      vertical: 2.5,
                    ),
                    child: Tile(letter.char, letter.type),
                  ),
              ],
            ),
          GuessInputState(
            onSubmitGuess: (guess) {
              // TODO, handle guess
              setState(() {
                _game.guess(guess);
              });
              // print(guess); // Temporary
            },
          ),
        ],
      ),
    );
  }
}

class GuessInputState extends StatefulWidget {
  const GuessInputState({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  @override
  State<GuessInputState> createState() => _GuessInputStateful();
}

class _GuessInputStateful extends State<GuessInputState> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    widget.onSubmitGuess(_textEditingController.text.trim());
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              focusNode: _focusNode,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (input) {
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_circle_up),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}
