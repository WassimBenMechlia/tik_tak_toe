import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tik_tak_toe/colors/app_colors.dart';
import 'package:tik_tak_toe/providers/players_turn.dart';
import 'package:tik_tak_toe/providers/user_choise_provider.dart';
import 'package:tik_tak_toe/providers/winner_provider.dart';
import 'package:tik_tak_toe/shapes/board_shape.dart';
import 'package:tik_tak_toe/shapes/circle_shape.dart';
import 'package:tik_tak_toe/shapes/winning_line.dart';
import 'package:tik_tak_toe/shapes/x_shape.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<String> choices = List.generate(9, (index) => '');
  Random random = Random();
  List<int>? winningLine;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(size: 40, color: AppColors.mainColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: BoardShape(),
                ),
                CustomPaint(
                  size: Size.infinite,
                  painter: winningLine != null
                      ? WinningLinePainter(
                          start: _getOffset(winningLine![0], screenWidth),
                          end: _getOffset(winningLine![1], screenWidth),
                        )
                      : null,
                ),
                _buildGridView(context, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomPaint _buildBoardShape() {
    return CustomPaint(
      size: Size.infinite,
      painter: BoardShape(),
    );
  }

  Widget _buildGridView(BuildContext context, double screenWidth) {
    return Consumer(
      builder: (context, ref, child) {
        String playersChoice =
            ref.watch(userChoiseProvider.notifier).getUserChoice();
        String playersTurn = ref.watch(playersTurnProvider);

        if (playersTurn == 'botsTurn') {
          _makeBotMove(ref, playersChoice);
        }

        return GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return _buildGridCell(
                context, index, playersChoice, screenWidth, ref);
          },
        );
      },
    );
  }

  void _makeBotMove(WidgetRef ref, String playersChoice) {
    if (choices.contains('')) {
      List<int> availableIndexes = choices
          .asMap()
          .entries
          .where((entry) => entry.value == '')
          .map((entry) => entry.key)
          .toList();

      if (availableIndexes.isNotEmpty) {
        int randomIndex =
            availableIndexes[random.nextInt(availableIndexes.length)];
        Future.delayed(Duration(seconds: 1), () async {
          setState(() {
            choices[randomIndex] = playersChoice == 'x' ? 'o' : 'x';
          });
          if (checkWin(choices)) {
            await endGame(context, 'You Lost!', choices, ref);
            setState(() {
              choices.fillRange(0, choices.length, '');
            });
          }
          ref.read(playersTurnProvider.notifier).userPlayed();
        });
      }
    }
  }

  GestureDetector _buildGridCell(BuildContext context, int index,
      String playersChoice, double screenWidth, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        if (choices[index] == '' &&
            ref.watch(playersTurnProvider) == 'playersTurn') {
          setState(() {
            choices[index] = playersChoice;
          });

          if (checkWin(choices)) {
            await endGame(context, 'You Won!', choices, ref);
            setState(() {
              choices.fillRange(0, choices.length, '');
            });
          } else {
            ref.read(playersTurnProvider.notifier).userPlayed();
          }
        }
      },
      child: Container(
        height: screenWidth,
        width: screenWidth,
        color: Colors.transparent,
        child: Center(
          child: choices[index] == ''
              ? Container()
              : CustomPaint(
                  size: Size.square(screenWidth * 0.7),
                  painter: choices[index] == 'x' ? XShape() : CircleShape(),
                ),
        ),
      ),
    );
  }

  Offset _getOffset(int index, double screenWidth) {
    double row = (index / 3).floor().toDouble();
    double column = index % 3.toDouble();
    return Offset(column * screenWidth + screenWidth / 2,
        row * screenWidth + screenWidth / 2);
  }

  List<int>? _getWinningLine() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (choices[combination[0]] == choices[combination[1]] &&
          choices[combination[1]] == choices[combination[2]] &&
          choices[combination[0]] != '') {
        return [combination[0], combination[2]];
      }
    }
    return null;
  }

  bool checkWin(List<String> choices) {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (choices[combination[0]] == choices[combination[1]] &&
          choices[combination[1]] == choices[combination[2]] &&
          choices[combination[0]] != '') {
        return true;
      }
    }

    return false;
  }
}

Future<void> endGame(BuildContext context, String text, List<String> choices,
    WidgetRef ref) async {
  ref.read(playersTurnProvider.notifier).endGame();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor:
            Colors.transparent, // Transparent background for the dialog
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(
              "assets/win_animation.json",
              fit: BoxFit.cover,
              width: double.infinity,
              frameRate: FrameRate(120),
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            // Overlay text
            Positioned(
              top: 20,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ensure text color is bright
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Play Again button
            Positioned(
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Text(
                      'Play Again?',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure text color is bright
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.6),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      );
    },
  );
}
