import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:nectar__rush/highscore.dart';
import 'package:nectar__rush/nectar_rush_game.dart';

import 'asset.dart';
import 'main_menu.dart';

class MainMenu extends StatefulWidget {
  static const String id = 'main_menu';
  final NectarRushGame game;
  MainMenu({super.key, required this.game});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isSoundOn = true;
 // Initial state: sound is on
  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();
    setState(() {
      if (isSoundOn) {
        FlameAudio.bgm.play('startandrestart_long.mp3', volume: 0.5);
      } else {
        FlameAudio.bgm.pause(); // Stop background music if sound is off
      }
    });
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          widget.game.overlays.remove(MainMenu.id);
          FlameAudio.bgm.stop(); // Resume background music when the game starts
          widget.game.resumeEngine();
        },
        child: Stack(
          children:[

            Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BGround_menu.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Nectar Rush',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MyGame',
                    ),
                  ),
                  Text(
                    "Collect nectar and avoid obstacles to score high!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'MyGame',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/start.png'),
                  const SizedBox(height: 40),
                  FutureBuilder<int>(
                    future: HighScoreManager.getHighScore(),
                    builder: (context, snapshot) {
                        final highScore = snapshot.data ?? 0;
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white, // Border color
                              width: 2.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(4.0), // Rounded corners
                          ),
                          child: Text(
                            "Beat the high score!\nCurrent High Score: $highScore",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                    },
                  ),
                ],
              ),
            ),
          ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(
                  isSoundOn ? Icons.volume_up : Icons.volume_off, // Change icon based on state
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {

                    // Toggle sound state
                    setState(() {isSoundOn = !isSoundOn;});
                },
              ),
            ),
        ],
        ),
      ),
    );
  }
}