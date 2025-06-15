import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'asset.dart';
import 'configuration.dart';
import 'nectar_rush_game.dart';

class Hive extends SpriteComponent with HasGameRef<NectarRushGame> {
  Hive({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);


  @override
  Future<void> onLoad() async {
    final hiveImage = await Flame.images.load(Asset.hive);
    sprite = Sprite(hiveImage);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt; // Move the hive left
    if (position.x + size.x < -120) {
      removeFromParent(); // Remove hive when it goes off-screen
    }
  }
}