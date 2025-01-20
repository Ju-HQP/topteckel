import 'package:flame/components.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import '../topteckel.dart';
import 'package:flutter/material.dart';

class AccessoryProperties {
  final String imagePath;
  final double width;
  final double height;
  final double offsetX;
  final double offsetY;

  AccessoryProperties({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.offsetX,
    required this.offsetY,
  });
}

final Map<String, AccessoryProperties> accessories = {
  'chapeau-TopTeckel': AccessoryProperties(
    imagePath: 'assets/images/chapeau-TopTeckel.png',
    width: 120,
    height: 120,
    offsetX: 10,
    offsetY: -130,
  ),
  'noeud': AccessoryProperties(
    imagePath: 'assets/images/noeud.png',
    width: 70,
    height: 70,
    offsetX: -10,
    offsetY: -40,
  ),
  'fleur-rose': AccessoryProperties(
    imagePath: 'assets/images/fleur-rose.png',
    width: 30,
    height: 30,
    offsetX: 30,
    offsetY: -100,
  ),
  'fleur-violette': AccessoryProperties(
    imagePath: 'assets/images/fleur-violette.png',
    width: 30,
    height: 30,
    offsetX: 30,
    offsetY: -100,
  ),
  'fleur-bleue': AccessoryProperties(
    imagePath: 'assets/images/fleur-bleue.png',
    width: 30,
    height: 30,
    offsetX: 30,
    offsetY: -100,
  ),
  'lunettes-de-soleil': AccessoryProperties(
    imagePath: 'assets/images/lunettes-de-soleil.png',
    width: 70,
    height: 70,
    offsetX: -10,
    offsetY: -100,
  ),
  'cone-de-chantier': AccessoryProperties(
    imagePath: 'assets/images/cone-de-chantier.png',
    width: 60,
    height: 60,
    offsetX: -2,
    offsetY: -143,
  ),
};

final Map<String, AccessoryProperties> accessoriesGame = {
  'chapeau-TopTeckel': AccessoryProperties(
    imagePath: 'chapeau-TopTeckel.png',
    width: 90,
    height: 40,
    offsetX: 8,
    offsetY: -105,
  ),
  'noeud': AccessoryProperties(
    imagePath: 'noeud.png',
    width: 50,
    height: 25,
    offsetX: -10,
    offsetY: -33,
  ),
  'fleur-rose': AccessoryProperties(
    imagePath: 'fleur-rose.png',
    width: 24,
    height: 24,
    offsetX: 25,
    offsetY: -83,
  ),
  'fleur-violette': AccessoryProperties(
    imagePath: 'fleur-violette.png',
    width: 24,
    height: 24,
    offsetX: 25,
    offsetY: -83,
  ),
  'fleur-bleue': AccessoryProperties(
    imagePath: 'fleur-bleue.png',
    width: 24,
    height: 24,
    offsetX: 25,
    offsetY: -83,
  ),
  'lunettes-de-soleil': AccessoryProperties(
    imagePath: 'lunettes-de-soleil.png',
    width: 50,
    height: 20,
    offsetX: -8,
    offsetY: -83,
  ),
  'cone-de-chantier': AccessoryProperties(
    imagePath: 'cone-de-chantier.png',
    width: 45,
    height: 45,
    offsetX: -2,
    offsetY: -116,
  ),
};