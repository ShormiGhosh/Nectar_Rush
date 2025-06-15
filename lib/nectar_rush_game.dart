import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart'; // Import for Colors
import 'package:nectar__rush/background.dart';
import 'package:nectar__rush/configuration.dart';
import 'package:nectar__rush/ground.dart';
import 'package:nectar__rush/webGroup.dart';

import 'bee.dart';
import 'game_pause_screen.dart';
import 'hive_spawner.dart';

class NectarRushGame extends FlameGame with TapDetector, HasCollisionDetection {
  NectarRushGame();
  late Bee bee;
  bool isPause = false;
  bool isCollision = false;
  late TextComponent scoreText;
  Timer interval = Timer(Config.web_interval, repeat: true);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    addAll([
      Background(),
      Ground(),
      bee = Bee(),
      scoreText = score(),
      HiveSpawner(),
    ]);
    add(await pauseButton());
    interval.onTick = () => add(WebGroup());
  }

  /// pause button on top right corner
  Future<ButtonComponent> pauseButton() async {
    return ButtonComponent(
      position: Vector2(size.x - 40, 30),
      size: Vector2(30, 30),
      button: SpriteComponent(
        sprite: await Sprite.load('pause_button.png'), // Load the sprite here
        size: Vector2(30, 30),
      ),
      onPressed: () {
         if(isPause){
           resumeEngine();
         }
         else{
           pauseEngine();
         }
        isPause = !isPause;
      },
    );
  }

  TextComponent score() {
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 50,
          color: Colors.yellow,
          fontWeight: FontWeight.w500,
          fontFamily: 'MyGame',
        ),
      ),
    );
  }

  @override
  void onTap() {
    super.onTap();
    bee.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    scoreText.text = 'Score: ${bee.score}';
  }
}
