import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:topteckel/src/config.dart';

import '../topteckel.dart';
import 'ball.dart';
import 'dog.dart';

// La classe Objet globale : regroupe les caractéristiques de vitesse (velocity), de dimensions et de positionnement de l'objet.
// Les classes spécifiques aux objets gère le sprite et les points attribués.

class Objet extends SpriteComponent
    with CollisionCallbacks, HasGameReference<TopTeckel> {
  Objet({required this.velocity, required super.position})
      : super(
          size: Vector2(objectWidth, objectHeight),
          anchor: Anchor.center,
        );
  Vector2 velocity;

  void addSpeed() {
    print("Vitesse avant");
    print(velocity);
    velocity.y *= 1.5; // Augmente la vitesse de 50%, ajustez comme nécessaire
    print("Vitesse après");
    print(velocity);
  }

// update est la méthode utilisée à chaque frame du jeu, on met à jour la position dans cette fonction
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

// Fonction de respawn des objets selon les probas suivantes : 65% positif, 30% négatif, 5% question
  void respawnObject() {
    double coordX = position.x; // récupère la position de l'objet actuel pour créer le nouvel objet
    var rand = Random();
    // Random().nextDouble() * 256; // Value is >= 0.0 and < 256.0.
    double aleaTime = (rand.nextDouble() * (delai+1)) * 1000; // durée aléatoire pour le délai >0 et <= 3
    Future.delayed(Duration(milliseconds: aleaTime.toInt()), () {
      // setState(() {
      //   // Here you can write your code for open new view
      // });

// voir si j'ai besoin de faire un autre chiffre random
      var newrand = Random().nextDouble();

      switch(rand){
        case <0.05 : break;
        case 
      }
      // Créer un nouvel objet
      game.world.add(
        GoodObject(
            position: Vector2(coordX, spawnHeightObjects),
            // vector et vitesse à revoir
            velocity: vitesseJeu),
      );
    });
  }


  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent(); // efface l'objet brique
    game.score.value++; // ajoute un point au score

    // fin du jeu car toutes les briques sotn cassées
    if (game.world.children.query<Objet>().length == 1) {
      // si il n'y a plus de brique
      game.playState = PlayState.won; // met l'état du jeu à victoire
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Dog>());
    }
  }
}
