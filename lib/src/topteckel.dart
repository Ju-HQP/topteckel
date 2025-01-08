import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'config.dart';

// Fichier principal de coordination du jeu

// états du jeu
enum PlayState { welcome, playing, gameOver, won }

class TopTeckel extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  // keyboard pour l'entrée clavier, TapDetector pour l'appui
  TopTeckel()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => size.x;
  double get height => size.y;

  final rand = math.Random();

// gestion du score
  final ValueNotifier<int> score = ValueNotifier(0);

// Gestion des overlays en fonction de l'état du jeu
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // place le viseur en haut à gauche (au centre par défaut) pour définir les coordonnées
    camera.viewfinder.anchor = Anchor.topLeft;

// world de Flame représente l'univers du jeu
    world.add(PlayArea());

    playState = PlayState.welcome;
  }

// l'affichage du gameplay ne se fait plus au lancement (onLoad) mais avec l'état du jeu et la fonction start
  void startGame() {
// si le jeu est déjà en cours la fonction ne fait rien
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Dog>());
    world.removeAll(world.children.query<GoodObject>());
    world.removeAll(world.children.query<BadObject>());
    // world.removeAll(world.children.query<QuestionObject>());


    playState = PlayState.playing;

    // initialise le score à 0
    score.value = 0;

    world.add(Dog(
        size: Vector2(dogWidth, dogHeight),
        // cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.85)));
    print("Dog size: $batWidth x $batHeight");

// Pour les briques
    // world.addAll([
    //   // boucle pour générer les briques
    //   for (var i = 0; i < brickColors.length; i++)
    //     for (var j = 1; j <= 5; j++) // 5 car il y a 5 lignes de briques
    //       Objet(
    //         position: Vector2(
    //           (i + 0.5) * brickWidth + (i + 1) * brickGutter,
    //           (j + 2.0) * brickHeight + j * brickGutter,
    //         ),
    //         color: brickColors[i],
    //       ),
    // ]);
// Pour les objets
//  Affichage d'une ampoule qui tombe

// Coordonnées objet spawn : 133.25 - 317.75 - 502.25 - 686.75s

// Random().nextDouble() * 256; // Value is >= 0.0 and < 256.0.
    for (var i = 0; i < 4; i++) {
      var rand = math.Random();
      double aleaTime = (rand.nextDouble() * 2) *
          1000; // durée aléatoire pour le délai entre et 0 et 1 seconde
      Future.delayed(Duration(milliseconds: aleaTime.toInt()), () {
        world.add(
          GoodObject(Vector2(objectZoneSpawnGap + other * i,
                  spawnHeightObjects), //écart de base + i *(largeur + ecart entre objets), hauteur de spawn de config
              // vector et vitesse à revoir
               Vector2(0, height * 0.2).normalized()
                ..scale(height / 4)),
        );
      });
    }
    // world.addAll([
    //   for (var i = 0; i < 4; i++)
    //     GoodObject(
    //         position: Vector2(objectZoneSpawnGap + other * i,
    //             spawnHeightObjects), //écart de base + i *(largeur + ecart entre objets), hauteur de spawn de config
    //         // vector et vitesse à revoir
    //         velocity: Vector2(0, height * 0.2).normalized()
    //           ..scale(height / 4)),
    // ]);

    // boucle de génération
    // tirage de l'objet aléatoirement avec proba
    // ça c'est par défaut mais il faudrait le faire en update

    // Active le mode debug pour l'ensemble des composants
    debugMode = true;
  }

// Gestion de l'interaction d'Appui
  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Dog>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Dog>().first.moveBy(batStep);
      // ajoute les entrées espace et entrée du clavier, avec entrée qui lance la fonction startGame()
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);

  @override
  void update(double dt) {
    super.update(dt);
    // Boucle pour chaque objet positif
    world.children.whereType<GoodObject>().forEach((objet) {
      // Augmentation de la vitesse en fonction du palier passé
      for (int unPalier in paliersDeScore) {
        if (score.value >= unPalier && !paliersAtteints.contains(unPalier)) {
          vitesseJeu = Vector2(vitesseJeu.x, vitesseJeu.y * coeffVitesse);
          objet.velocity = vitesseJeu;
          delai -= 0.4; // Calcul de diminution -> 4 secondes de base jusqu'à max 1 sec donc 3/7 = 0.42
          print(delai);
          paliersAtteints.add(unPalier);
        }
      }
    });
  }
}
