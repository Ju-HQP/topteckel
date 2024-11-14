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

class TopTeckel extends FlameGame with HasCollisionDetection,KeyboardEvents {
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
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    // place le viseur en haut à gauche (au centre par défaut)
    camera.viewfinder.anchor = Anchor.topLeft;

// world de Flame représente l'univers du jeu
    world.add(PlayArea());
    // ajout du composant Balle
    world.add(Ball(
      radius: ballRadius,
      position: size/2,
      // vector et vitesse à revoir
      velocity: Vector2((rand.nextDouble())- 0.5 * width, height * 0.2).normalized()..scale(height/4)
    ));
    
  world.add(Dog(                                              // Add from here...
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95)));
        
      // Active le mode debug pour l'ensemble des composants
    debugMode = true;

    @override                                                     // Add from here...
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Dog>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Dog>().first.moveBy(batStep);
    }
    return KeyEventResult.handled;
  }  
  }
}
