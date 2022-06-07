import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/history_screen.dart';

import 'History.dart';
import 'game_logic.dart';
import 'history_model.dart';
import 'shared_preference_service.dart';

/// home screen (main screen)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// state active player X or O
  String activePlayer = Player.x;

  /// state if the game still running or finished
  bool gameOver = false;

  /// state number of turn used
  int turn = 0;

  /// result of the game win or lose or draw
  String result = '';

  /// game object to start the game
  Game game = Game();

  /// state if game against device or human
  bool isSwitched = false;

  /// animated game message, its size and color
  String _gameMsg = "Win";
  double _gameMsgSize = 0;
  Color _gameMsgColor = Colors.transparent;

  /// main home ui including all components
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            OrientationBuilder(builder: (ctx, orientation) {
              final isLandscape = orientation == Orientation.landscape;
              return isLandscape
                  ? Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...firstBlock(),
                              ...lastBlock(),
                            ],
                          ),
                        ),
                        _expanded(context),
                      ],
                    )
                  : Column(
                      children: [
                        ...firstBlock(),
                        _expanded(context),
                        ...lastBlock(),
                      ],
                    );
            }),
            SizedBox(
              width: double.maxFinite,
              child: AnimatedDefaultTextStyle(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape &&
                            _gameMsgSize > 0
                        ? calculateScreenWidthFitFontSize(
                            _gameMsg,
                            TextStyle(
                                color: _gameMsgColor, fontFamily: 'Canterbury'),
                            0,
                            MediaQuery.of(context).size.width)
                        : _gameMsgSize,
                    color: _gameMsgColor,
                    fontFamily: 'Canterbury'),
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Text(
                    _gameMsg,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// first part of home ui switch between computer and human player state ,and current player name
  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        value: isSwitched,
        onChanged: (nVal) {
          if (turn == 0 || gameOver) {
            setState(() {
              isSwitched = nVal;
            });
            reset();
            showSnackBarCustom(
                "Turn Two Player State ${isSwitched ? 'On' : 'Off'}");
          } else {
            showSnackBarCustom(
                "You can't change game state during existing game is in action");
          }
        },
        title: const Text(
          "Turn on/off two player",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
      InkWell(
        onTap: () => SharedPreferenceService.getHistory().then((value) {
          if (value != null) {
            History history = History.fromJson(jsonDecode(value));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HistoryScreen(history: history),
              ),
            );
          }
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Game History",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              Icon(
                Icons.history,
                size: 30,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.maxFinite,
          child: FittedBox(
            child: Text(
              "It's player $activePlayer turn".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  /// game components in home ui
  Expanded _expanded(BuildContext context) {
    return Expanded(
      flex: 4,
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: gameOver ? null : () => _onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? Player.x
                      : Player.playerO.contains(index)
                          ? Player.o
                          : Player.empty,
                  style: TextStyle(
                      color: Player.playerX.contains(index)
                          ? Colors.blue
                          : Colors.pink,
                      fontSize: 52),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Last part of home screen resulting text and repeat game button
  List<Widget> lastBlock() {
    return [
      Text(
        result,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 42,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 8),
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).splashColor),
          ),
          onPressed: () => reset(),
          icon: const Icon(Icons.replay),
          label: const Text(
            "Repeat the game",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    ];
  }

  /// method calculating required font size for result text to fit screen width
  double calculateScreenWidthFitFontSize(
      String text, TextStyle style, double startFontSize, double maxWidth) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    var currentFontSize = startFontSize;
    for (var i = 0; i < 150; i++) {
      final nextFontSize = currentFontSize + 1;
      final nextTextStyle = style.copyWith(fontSize: nextFontSize);
      textPainter.text = TextSpan(text: text, style: nextTextStyle);
      textPainter.layout();
      if (textPainter.width >= maxWidth) {
        break;
      } else {
        currentFontSize = nextFontSize;
        // continue iteration
      }
    }
    return currentFontSize;
  }

  /// showing snackBar with specific text message and hide others showing
  void showSnackBarCustom(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).shadowColor,
      content: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      action: SnackBarAction(
          label: "Close",
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context)
              .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss)),
    ));
  }

  /// perform game action
  _onTap(int index) async {
    if (!Player.playerX.contains(index) && !Player.playerO.contains(index)) {
      game.playGame(index: index, activePlayer: activePlayer);
      updateState();
      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer: activePlayer);
        updateState();
      }
    }
  }

  /// reset game to start new one
  void reset() {
    setState(() {
      Player.playerX = [];
      Player.playerO = [];
      activePlayer = Player.x;
      gameOver = false;
      turn = 0;
      result = '';
      _gameMsgSize = 0;
      _gameMsg = "";
      _gameMsgColor = Colors.transparent;
    });
  }

  updateGameHistory(String winner, bool isTwoPlayer) {
    SharedPreferenceService.getHistory().then((value) {
      History data = History(history: []);
      if (value != null) {
        data = History.fromJson(jsonDecode(value));
      }
      data.history.add(HistoryModel(
          winner: winner,
          isTwoPlayer: isTwoPlayer,
          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"));
      SharedPreferenceService.saveHistory(jsonEncode(data.toJson()));
    });
  }

  /// update states after each action
  void updateState() {
    setState(() {
      activePlayer = activePlayer == Player.x ? Player.o : Player.x;
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer.isNotEmpty) {
        result = "Winner is player $winnerPlayer";
        gameOver = true;
        _gameMsg = isSwitched
            ? "$winnerPlayer Wins"
            : winnerPlayer == Player.x
                ? "You Won"
                : "You Failed";
        _gameMsgColor = isSwitched || winnerPlayer == Player.x
            ? Colors.lightGreen
            : Colors.red;
        _gameMsgSize = calculateScreenWidthFitFontSize(
            _gameMsg,
            TextStyle(color: _gameMsgColor, fontFamily: 'Canterbury'),
            0,
            MediaQuery.of(context).size.width);
        updateGameHistory(winnerPlayer, isSwitched);
      } else if (winnerPlayer.isEmpty && turn == 9) {
        result = "Game is Draw";
        gameOver = true;
        _gameMsg = "Draw";
        _gameMsgSize = calculateScreenWidthFitFontSize(
            _gameMsg,
            TextStyle(color: _gameMsgColor, fontFamily: 'Canterbury'),
            0,
            MediaQuery.of(context).size.width);
        _gameMsgColor = Colors.white;
        updateGameHistory("draw", isSwitched);
      }
    });
  }
}
