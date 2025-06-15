import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:nectar__rush/asset.dart';
import 'package:nectar__rush/bee_movement.dart';
import 'package:nectar__rush/configuration.dart';
import 'package:nectar__rush/nectar_rush_game.dart';
import 'package:nectar__rush/web.dart';

import 'highscore.dart';
import 'hive.dart';

class Bee extends SpriteGroupComponent<BeeMovement>
    with HasGameRef<NectarRushGame>, CollisionCallbacks {
  Bee();
int score = 0;
  @override
  Future<void> onLoad() async {
      final beeMid = await gameRef.loadSprite(Asset.beeForward);
      final beeUp = await gameRef.loadSprite(Asset.beeUp);
      final beeDown = await gameRef.loadSprite(Asset.beeDown);
      size = Vector2(50, 50);
      position = Vector2(50, gameRef.size.y / 2-size.y/2);

      sprites = {
        BeeMovement.middle: beeMid,
        BeeMovement.up: beeUp,
        BeeMovement.down: beeDown,
      };
      current = BeeMovement.middle;
      add(CircleHitbox());
  }
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Hive) {
      score += 10;
      FlameAudio.play('achieve_point.wav', volume: 0.7);
      other.removeFromParent(); // Remove the hive after collection
    }
    else {
      super.onCollisionStart(intersectionPoints, other);
      gameOver();
    }
  }
  void fly(){
    add(MoveByEffect(Vector2(0.0 ,Config.gravity), EffectController
      (duration: 0.2,curve: Curves.decelerate),onComplete: ()=>current=BeeMovement.down),);
    current=BeeMovement.up;
  }
  @override
  void update(double dt) {
    super.update(dt);
    position.y+=Config.bee_velocity*dt;
    if(position.y<1){
      gameOver();
    }
  }

  void gameOver() async {
    FlameAudio.play('punch.wav');
    // Save the high score
    await HighScoreManager.saveHighScore(score);

    gameRef.overlays.add('game_over');
    gameRef.pauseEngine();
    game.isCollision = true;
    //FlameAudio.loop("startandrestart_long.mp3", volume: 0.5);
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2-size.y/2);
    score = 0;
  }
}