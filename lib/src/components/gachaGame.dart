import 'dart:async';
import 'dart:math';

import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';

class GachaGame {
  static final List<String> allAccessories = [
    'chapeau-TopTeckel',
    'noeud',
    'fleur-rose',
    'fleur-violette',
    'fleur-bleue',
    'lunettes-de-soleil',
    'cone-de-chantier',
  ];

  static Future<String> drawAccessory(User user) async {
    if (user.totalTicketsGame == null || user.totalTicketsGame! <= 0) {
      return "Pas assez de tickets !";
    }

    // Déduire un ticket
    user.totalTicketsGame = user.totalTicketsGame! - 1;

    // Simuler un délai de 3 secondes
    await Future.delayed(const Duration(seconds: 3));

    // Choisir un accessoire au hasard
    final random = Random();
    final newAccessory = allAccessories[random.nextInt(allAccessories.length)];

    // Vérifier si l'utilisateur possède déjà cet accessoire
    if (!user.accessoriesList.contains(newAccessory)) {
      user.accessoriesList.add(newAccessory);

      // Mettre à jour dans la base de données
      await Dao.updateUser(user);

      return "Nouveau !\nVous avez gagné : $newAccessory";
    }
    await Dao.updateUser(user);
    return "Vous avez gagné : $newAccessory"; // Accessoire déjà possédé
  }
}