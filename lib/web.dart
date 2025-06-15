import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:nectar__rush/asset.dart';
import 'package:nectar__rush/configuration.dart';
import 'package:nectar__rush/nectar_rush_game.dart';
import 'package:nectar__rush/webPos.dart';

class Web extends SpriteComponent with HasGameRef<NectarRushGame> {
  Web({required this.webPosition, required this.webSize});

  final WebPos webPosition;
  final double webSize;
  @override
  Future<void> onLoad() async {
    final webImage = await Flame.images.load(Asset.spiderWeb);
    size = Vector2(webSize, webSize);
    switch (webPosition) {
      case WebPos.top:
        position.y = 20;
        break;
      case WebPos.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight-20;
        break;
    }
    sprite = Sprite(webImage);
    add(CircleHitbox(radius : webSize / 2*0.8));
  }
}

