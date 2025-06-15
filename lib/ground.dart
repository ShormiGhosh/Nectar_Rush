import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:nectar__rush/configuration.dart';
import 'package:nectar__rush/nectar_rush_game.dart';

import 'asset.dart';

class Ground extends ParallaxComponent<NectarRushGame> with HasGameRef<NectarRushGame>, CollisionCallbacks {
  Future<void> onLoad()async{
    final ground=await Flame.images.load(Asset.ground);
    parallax=Parallax([
       ParallaxLayer(
         ParallaxImage(ground,
         fill: LayerFill.none,),
     ),
   ]);
    add(RectangleHitbox(
      size: Vector2(gameRef.size.x, Config.groundHeight),
      position: Vector2(0,gameRef.size.y-Config.groundHeight),
    ));
  }
  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x=Config.gameSpeed;
  }
}