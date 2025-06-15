import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'configuration.dart';
import 'hive.dart';

class HiveSpawner extends PositionComponent with HasGameRef {
  final Random _random = Random();
  late Timer _spawnTimer;

  HiveSpawner() {
    _spawnTimer = Timer(_getRandomInterval(), onTick: _spawnHive, repeat: false);
  }

  @override
  void onMount() {
    _spawnTimer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _spawnTimer.update(dt);
    super.update(dt);
  }

  void _spawnHive() {
    final screenWidth = gameRef.size.x;
    final screenHeight = gameRef.size.y;

    // Randomize position and size
    final x = _random.nextDouble() * screenWidth;
    final y = screenHeight * 0.4 + _random.nextDouble() * screenHeight * 0.2;
    final size = 30 + _random.nextDouble() * 40; // Random size between 30 and 70

    final hive = Hive(
      position: Vector2(x, y),
      size: Vector2(size, size+30),
    );

    // Add slight movement to the hive
    hive.add(MoveEffect.by(
      Vector2(_random.nextDouble() * 20 - 10, _random.nextDouble() * 20 - 10),
      EffectController(duration: 2, reverseDuration: 2, infinite: true),
    ));

    gameRef.add(hive);

    // Restart the timer with a new random interval
    _spawnTimer
      ..stop()
      ..start();
  }

  double _getRandomInterval() {
    // Generate a random interval between 2 and 5 seconds
    return 3 + _random.nextDouble() * 5;
  }
}