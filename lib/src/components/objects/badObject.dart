import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../play_area.dart'; // pour les collisions avec le mur
import '../dog.dart'; //pour les collisions avec la balle
import 'object.dart';

class BadObject
    extends Object // positionComponent affiche l'objet à l'écran (remplace render)
   {
    BadObject(position, velocity) : super (position: position, velocity: velocity);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite('object_bad.png'); //loadSprite va direct dans assets/images
      // size = sprite!.srcSize;
      print("Sprite Objet Négatif. Size: $size.");
    } catch (e) {
      print("Error Bad Object: $e");
    }
// hitbox à tester
    add(CircleHitbox());
  }


  // fonction pour gérer les collisions
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    var collisionWith = other; // collisionWith représente l'objet en collision
    super.onCollisionStart(intersectionPoints,
        collisionWith); 
    if (collisionWith is PlayArea) {
              // Quand l'objet tombe
      if (intersectionPoints.first.y >= game.height) {
        // RemoveEffect permet de retirer l'objet du jeu, après l'avoir laissé quitter l'espace de jeu visible
        add(RemoveEffect(
            delay: 0.0,
            onComplete: () {
              respawnObject();
            }));
      }
    } else if (collisionWith is Dog) {
      // collision avec le chien
      add(RemoveEffect(
          delay: 0.0,
          onComplete: () {
            game.score.value -= 10; // à terme : enlève une vie
            respawnObject();
          }));
    }
    else {
      print('collision with $collisionWith');
    }
  }
}
