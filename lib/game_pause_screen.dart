import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:nectar__rush/main_menu.dart';
import 'package:nectar__rush/nectar_rush_game.dart';

class GameScreen extends StatelessWidget {
  final NectarRushGame game;
  static const String id = 'game_screen';

  const GameScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed:(){
         game.overlays.remove('game_screen');
          game.resumeEngine();
          FlameAudio.bgm.stop();
        }, child: Text("Quit Game")),
        SizedBox(height: 20),
        ElevatedButton(onPressed:(){
          game.overlays.remove('game_screen');
          Navigator.pushReplacementNamed(context, MainMenu.id);
        }, child: Text("Quit Game")),
      ],
    );
  }
}