import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../topteckel.dart';
import 'ball.dart';
import 'dog.dart';

class Objet extends RectangleComponent
    with CollisionCallbacks, HasGameReference<TopTeckel> {
  Objet({required super.position, required Color color})
      : super(
          // size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [RectangleHitbox()],
        );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent(); // efface l'objet brique
    game.score.value++; // ajoute un point au score
    
   // fin du jeu car toutes les briques sotn cassées
    if (game.world.children.query<Objet>().length == 1) { // si il n'y a plus de brique
      game.playState = PlayState.won; // met l'état du jeu à victoire
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Dog>());
    }
  }
}
