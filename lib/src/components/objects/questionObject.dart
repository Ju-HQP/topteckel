import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../components.dart';
import 'object.dart';

class QuestionObject
    extends Object // positionComponent affiche l'objet à l'écran (remplace render)
   {
    QuestionObject(position, velocity) : super (position: position, velocity: velocity);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite('object_question.png'); //loadSprite va direct dans assets/images
      // size = sprite!.srcSize;
      print("Sprite Objet Question. Size: $size.");
    } catch (e) {
      print("Error loading Question Object sprite: $e");
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
              game.score.value--; // enlève un point au score
              respawnObject();
            }));
      }
    } else if (collisionWith is DogWithAccessory) {
      // collision avec le chien
      add(RemoveEffect(
          delay: 0.0,
          onComplete: () {
            game.score.value++; // ajoute un point au score
            respawnObject();
          }));
    }
    else {
      print('collision with $collisionWith');
    }
  }
}
