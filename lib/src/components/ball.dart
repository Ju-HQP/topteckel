import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';

import '../topteckel.dart';
import 'play_area.dart'; // pour les collisions

class Ball extends CircleComponent
with CollisionCallbacks, HasGameReference<TopTeckel> { // pour les collisions
  Ball({
    // velocity => changement de position
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color.fromARGB(255, 253, 142, 38)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]); // ajout de l'hitbox de la balle

 // velocity => object Vector2 pour que cela corresponde à vitesse et direction
  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  // fonction pour gérer les collisions
   @override                                                     // Add from here...
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        removeFromParent();
      }
    } else {
      debugPrint('collision with $other');
    }
  }  
}
