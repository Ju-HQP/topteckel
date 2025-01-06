import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:topteckel/src/config.dart';
import '../topteckel.dart';
import 'play_area.dart'; // pour les collisions avec le mur
import 'dog.dart'; //pour les collisions avec la balle

class BadObject
    extends SpriteComponent // positionComponent affiche l'objet à l'écran (remplace render)
    with
        CollisionCallbacks,
        HasGameReference<TopTeckel> {
  // dragCallBacks pour l'interaction de drag
  BadObject({
    required this.velocity,
    required super.position,
  }) : super(
          size: Vector2(objectWidth, objectHeight),
          anchor: Anchor.center,
        );
  // velocity => object Vector2 pour que cela corresponde à vitesse et direction
  Vector2 velocity;
  bool speedAjoutee = false;

   void addSpeed() {
     print("Vitesse avant");
    print(velocity);
    velocity.y *= 1.5; // Augmente la vitesse de 50%, ajustez comme nécessaire
    print("Vitesse après");
    print(velocity);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite('object_bad.png'); //loadSprite va direct dans assets/images
      // size = sprite!.srcSize;
      print("Sprite loaded successfully. Size: $size.");
    } catch (e) {
      print("Error loading sprite: $e");
    }
// hitbox à tester
    add(CircleHitbox());
  }

  

// update est la méthode utilisée à chaque frame du jeu, on met à jour la position dans cette fonction
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

// Fonction prévue plus tard pour la classe object
  void respawnObject() {
    print(delai);
    double coordX = position.x; // récupère la position de l'objet actuel pour créer le nouvel objet
    var rand = Random();
    // Random().nextDouble() * 256; // Value is >= 0.0 and < 256.0.
    double aleaTime = (rand.nextDouble() * (delai+1)) * 1000; // durée aléatoire pour le délai >0 et <= 3
    Future.delayed(Duration(milliseconds: aleaTime.toInt()), () {
      // setState(() {
      //   // Here you can write your code for open new view
      // });
      // Créer un nouvel objet positif
      game.world.add(
        BadObject(
            position: Vector2(coordX, spawnHeightObjects),
            // vector et vitesse à revoir
            velocity: vitesseJeu),
      );
    });
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
    } else if (collisionWith is Dog) {
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
