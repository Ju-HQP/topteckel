import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';

import '../topteckel.dart';

class PlayArea extends RectangleComponent with HasGameReference<TopTeckel> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color.fromARGB(255, 35, 194, 223),
        children: [RectangleHitbox()], // pour l'ajout de collisions
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
