import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../components.dart';
import 'object.dart';

class GoodObject
    extends Object // positionComponent affiche l'objet à l'écran (remplace render)
{
  GoodObject(position, velocity)
      : super(position: position, velocity: velocity);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite(
          'object_good.png'); //loadSprite va direct dans assets/images
      // size = sprite!.srcSize;
      print("Sprite Objet Positif. Size: $size.");
    } catch (e) {
      print("Error loading Good Object sprite: $e");
    }
// hitbox à tester
    add(CircleHitbox());
  }

  // fonction pour gérer les collisions
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    var collisionWith = other; // collisionWith représente l'objet en collision
    super.onCollisionStart(intersectionPoints, collisionWith);
    if (collisionWith is PlayArea) {
      // Quand l'objet tombe
      if (intersectionPoints.first.y >= game.height) {
        // RemoveEffect permet de retirer l'objet du jeu, après l'avoir laissé quitter l'espace de jeu visible
        add(RemoveEffect(
            delay: 0.0,
            onComplete: () {
              game.score.value--; // enlève un point au score
              respawnObject();
            }));
      }
    } else if (collisionWith is Dog) {
      // collision avec le chien
      add(RemoveEffect(
          delay: 0.0,
          onComplete: () {
            game.score.value++; // ajoute un point au score
            respawnObject();
          }));
    } else {
      print('collision with $collisionWith');
    }
  }
}
