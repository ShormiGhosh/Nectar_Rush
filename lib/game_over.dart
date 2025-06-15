import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:nectar__rush/main_menu.dart';

import 'highscore.dart';
import 'nectar_rush_game.dart';

class GameOver extends StatelessWidget {
  static const String id = 'game_over';
  final NectarRushGame game;

  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: HighScoreManager.getHighScore(),
      builder: (context, snapshot) {
        final highScore = snapshot.data ?? 0;

        return Material(
          color: Colors.black38,
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Game Over",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MyGame',
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2.0
                      ..color = Colors.red, // Border color
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  snapshot.hasData && snapshot.data! <= game.bee.score
                      ? 'New High Score!'
                      : '',
                  style: TextStyle(
                    fontSize: 30,
                    color: snapshot.hasData && snapshot.data! <= game.bee.score
                        ? Colors.green
                        : Colors.transparent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MyGame',
                  ),
                ),
                Text(
                  'Score: ${game.bee.score}',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'MyGame',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'High Score: $highScore',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'MyGame',
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    game.bee.reset();
                    game.overlays.remove(GameOver.id);
                    game.resumeEngine();
                    FlameAudio.bgm.pause();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text('Restart'),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    game.bee.reset();
                    game.overlays.remove(GameOver.id);
                    game.overlays.add(MainMenu.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text('Back to Menu'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
