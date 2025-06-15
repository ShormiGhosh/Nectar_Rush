import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:nectar__rush/asset.dart';
import 'package:nectar__rush/nectar_rush_game.dart';

class Background extends SpriteComponent with HasGameRef<NectarRushGame>{
  Background();
  @override
  Future<void> onLoad() async {
    try {
      final background = await Flame.images.load(Asset.background);
      size = gameRef.size;
      sprite = Sprite(background);
    } catch (e) {
      print('Error loading background: $e');
    }
  }
}
