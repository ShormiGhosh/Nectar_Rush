import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_over.dart';
import 'main_menu.dart';
import 'nectar_rush_game.dart';

void main() {
  final game = NectarRushGame();
  runApp(
    GameWidget(game: game,initialActiveOverlays: const[MainMenu.id],
      overlayBuilderMap: {
      'main_menu': (context,_) => MainMenu(game: game),
        'game_over': (context,_) => GameOver(game: game),
    },)
  );
}
