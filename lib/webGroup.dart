import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:nectar__rush/nectar_rush_game.dart';
import 'package:nectar__rush/web.dart';
import 'package:nectar__rush/webPos.dart';

import 'configuration.dart';

class WebGroup extends PositionComponent with HasGameRef<NectarRushGame> {
  WebGroup();

  final rand = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGnd = gameRef.size.y - Config.groundHeight;
    final maxWebSize = heightMinusGnd / 2.5;
    final spaceBetweenWebs = 100 + rand.nextDouble() * heightMinusGnd / 4;
    final centerY =
        spaceBetweenWebs +
        rand.nextDouble() * (heightMinusGnd - spaceBetweenWebs);

    addAll([
      Web(webPosition: WebPos.top, webSize: min(maxWebSize,centerY - spaceBetweenWebs / 2)),
      Web(
        webPosition: WebPos.bottom,
        webSize: min(maxWebSize,heightMinusGnd - (centerY + spaceBetweenWebs / 2)),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
    if (position.x + size.x < -120) {
      removeFromParent();
      updateScore();
    }
    if (gameRef.isCollision) {
      removeFromParent();
      gameRef.isCollision = false;
    }
  }

  void updateScore() {
    gameRef.bee.score++;
    FlameAudio.play('assets/audio/achieve_point.wav');
  }
}
