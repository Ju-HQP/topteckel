import 'package:flame/game.dart';
import 'package:flutter/material.dart';
 
import "src/topteckel.dart";

void main() {
  final game = TopTeckel();
  runApp(GameWidget(game: game));
}
