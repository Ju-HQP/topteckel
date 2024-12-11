import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';

import '../topteckel.dart';
import 'play_area.dart'; // pour les collisions avec le mur
import 'dog.dart'; //pour les collisions avec la balle
import 'object.dart';

class Ball extends CircleComponent
with CollisionCallbacks, HasGameReference<TopTeckel> { // pour les collisions
  Ball({
    // velocity => changement de position
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier // coeff de vitesse en paramètre de l'objet
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color.fromARGB(255, 253, 142, 38)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]); // ajout de l'hitbox de la balle

 // velocity => object Vector2 pour que cela corresponde à vitesse et direction
  final Vector2 velocity;
  final double difficultyModifier; 

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  // fonction pour gérer les collisions
   @override                                                     // Add from here...
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other); // other représente l'objet en collision
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      }  else if (intersectionPoints.first.y >= game.height) {
         // RemoveEffect permet de retirer la balle du jeu, après l'avoir laissé quitter l'espace de jeu visible UTILE POUR OBJETS
        add(RemoveEffect(                                    
          delay: 0.35,
          onComplete: () { // quand la fonction est terminée, mets l'état du jeu en gameOver (la balle est tombée)                    
              game.playState = PlayState.gameOver;
            }
        ));
      }
    } else if (other is Dog) { // collision avec le chien
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
      } else if (other is Objet) {   // collision avec une brique                              
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);       
    } else {
      debugPrint('collision with $other');
    }
  }  
}

