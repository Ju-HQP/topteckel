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
    width: 76.5,
    height: 34,
    offsetX: 8,
    offsetY: -70,
  ),
  'noeud': AccessoryProperties(
    imagePath: 'noeud.png',
    width: 38,
    height: 19,
    offsetX: -8,
    offsetY: -20,
  ),
  'fleur-rose': AccessoryProperties(
    imagePath: 'fleur-rose.png',
    width: 14,
    height: 14,
    offsetX: 16,
    offsetY: -52,
  ),
  'fleur-violette': AccessoryProperties(
    imagePath: 'fleur-violette.png',
    width: 14,
    height: 14,
    offsetX: 16,
    offsetY: -52,
  ),
  'fleur-bleue': AccessoryProperties(
    imagePath: 'fleur-bleue.png',
    width: 14,
    height: 14,
    offsetX: 16,
    offsetY: -52,
  ),
  'lunettes-de-soleil': AccessoryProperties(
    imagePath: 'lunettes-de-soleil.png',
    width: 35,
    height: 14,
    offsetX: -4,
    offsetY: -53,
  ),
  'cone-de-chantier': AccessoryProperties(
    imagePath: 'cone-de-chantier.png',
    width: 34,
    height: 34,
    offsetX: -2,
    offsetY: -77,
  ),
};