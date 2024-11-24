import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'package:topteckel/src/config.dart';
import '../topteckel.dart';
import 'play_area.dart'; // pour les collisions avec le mur
import 'dog.dart'; //pour les collisions avec la balle

class GoodObject
    extends SpriteComponent // positionComponent affiche l'objet à l'écran (remplace render)
    with
        CollisionCallbacks,
        HasGameReference<TopTeckel> {
  // dragCallBacks pour l'interaction de drag
  GoodObject({
    required this.velocity,
    required super.position,
    required this.difficultyModifier,
  }) : super(
          size: Vector2(goodObjectWidth, goodObjectHeight),
          anchor: Anchor.center,
        );
  // velocity => object Vector2 pour que cela corresponde à vitesse et direction
  final Vector2 velocity;
  final double difficultyModifier;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite('piece.png');
      // size = sprite!.srcSize;
      print("Sprite loaded successfully. Size: $size.");
    } catch (e) {
      print("Error loading sprite: $e");
    }
// hitbox à tester
    add(CircleHitbox());
  }

// update est la méthode utilsiée à chaque frame du jeu, on met à jour la position dans cette fonction
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    print(velocity);
  }

  // fonction pour gérer les collisions
  @override // Add from here...
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(
        intersectionPoints, other); // other représente l'objet en collision
    if (other is PlayArea) {
      if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) { // Quand la balle tombe
        // RemoveEffect permet de retirer l'objet du jeu, après l'avoir laissé quitter l'espace de jeu visible
        add(RemoveEffect(
            delay: 0.35,
            onComplete: () {
              // game.playState = PlayState.gameOver;
                  game.score.value--; // ajoute un point au score
            }));
      }
    } else if (other is Dog) {
      // collision avec le chien
      add(RemoveEffect(
          delay: 0.02,
          onComplete: () {
                game.score.value++; // ajoute un point au score
          }));
    }
    // velocity.setFrom(velocity * difficultyModifier);
    else {
      debugPrint('collision with $other');
    }
  }
}
