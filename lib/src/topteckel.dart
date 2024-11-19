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

    // place le viseur en haut à gauche (au centre par défaut)
    camera.viewfinder.anchor = Anchor.topLeft;

// world de Flame représente l'univers du jeu
    world.add(PlayArea());

    playState = PlayState.welcome;
  }

// l'affichage du gameplay ne se fait plus au lancement (onLoad) mais avec l'état du jeu et la fonction start
  void startGame() {
// si le jeu est déjà en cours la fonction ne fait rien
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Dog>());
    world.removeAll(world.children.query<Objet>());

    playState = PlayState.playing;

    // initialise le score à 0
     score.value = 0;
     
    // ajout du composant Balle
    world.add(Ball(
        difficultyModifier: difficultyModifier,
        radius: ballRadius,
        position: size / 2,
        // vector et vitesse à revoir
        velocity: Vector2((rand.nextDouble()) - 0.5 * width, height * 0.2)
            .normalized()
          ..scale(height / 4)));

    world.add(Dog(
        size: Vector2(batWidth, batHeight),
        // cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.85)));

    world.addAll([
      // boucle pour générer les briques
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++) // 5 car il y a 5 briques par ligne
          Objet(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);

    // Active le mode debug pour l'ensemble des composants
    // debugMode = true;
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
}
