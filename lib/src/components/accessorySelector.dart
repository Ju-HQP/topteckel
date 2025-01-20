import 'package:flame/components.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/accessoryProperties.dart';
import '../topteckel.dart';
import 'package:flutter/material.dart';

class AccessorySelector extends StatelessWidget {
  final User user;
  final Function(String?) onAccessorySelected;

  AccessorySelector({super.key, required this.user, required this.onAccessorySelected});

  late List<String> accessoriesKeys = [
  'chapeau-TopTeckel',
  'noeud',
  'fleur-rose',
  'fleur-violette',
  'fleur-bleue',
  'lunettes-de-soleil',
  'cone-de-chantier',
];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        // Option pour ne rien porter
        GestureDetector(
          onTap: () => onAccessorySelected(null),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Aucun'),
          ),
        ),
        ...user.accessoriesList.map((key) {
          final accessory = accessories[key];
          return GestureDetector(
            onTap: () => onAccessorySelected(key),
            child: Image.asset(
              accessory!.imagePath,
              width: 50,
              height: 50,
            ),
          );
        })
      ],
    );
  }

  void onAccessorySelected1(String? accessory) {
  user.accessory = accessory;
  }
}


