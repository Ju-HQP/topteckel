import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../components.dart';
import '../../config.dart';
import '../../topteckel.dart';

// La classe Objet globale : regroupe les caractéristiques de vitesse (velocity), de dimensions et de positionnement de l'objet.
// Les classes spécifiques aux objets gère le sprite et les points attribués.

class Object extends SpriteComponent
    with CollisionCallbacks, HasGameReference<TopTeckel> {
  Object({required this.velocity, required super.position})
      : super(
          size: Vector2(objectWidth, objectHeight),
          anchor: Anchor.center,
        );
  Vector2 velocity;

  void addSpeed() {
    velocity.y *= 1.5; // Augmente la vitesse de 50%, ajustez comme nécessaire
  }

// update est la méthode utilisée à chaque frame du jeu, on met à jour la position dans cette fonction
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

// Fonction de respawn des objets selon les probas suivantes : 80% positif, 15% négatif, 5% question
  void respawnObject() {
    double coordX = position
        .x; // récupère la position de l'objet actuel pour créer le nouvel objet
    var rand = Random();
    double aleaTime = (rand.nextDouble() * (delai + 1)) *
        1000; // durée aléatoire pour le délai >0 et <= 3
    Future.delayed(Duration(milliseconds: aleaTime.toInt()), () {
      double newrand = rand.nextDouble();
      // Créer un nouvel objet
      switch (newrand) {
        case < 0.05:
          game.world.add(
            QuestionObject(Vector2(coordX, spawnHeightObjects), vitesseJeu),
          );
          break;
        case < 0.20:
          game.world.add(
            BadObject(Vector2(coordX, spawnHeightObjects), vitesseJeu),
          );
          break;
        case <= 1:
          game.world.add(
            GoodObject(Vector2(coordX, spawnHeightObjects), vitesseJeu),
          );
          break;
      }
    });
  }
}
