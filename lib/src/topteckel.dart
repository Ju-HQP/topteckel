import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/buildDogWithAccessory.dart';
import 'package:topteckel/src/components/dogWithAccessory.dart';

import 'components/components.dart';
import 'config.dart';

// Fichier principal de coordination du jeu

// états du jeu
enum PlayState { welcome, playing, gameOver, won }

class TopTeckel extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  // keyboard pour l'entrée clavier, TapDetector pour l'appui
  
  // Variables de jeu
  final ValueNotifier<int> score = ValueNotifier(0); // Score actuel
  final ValueNotifier<int> lives = ValueNotifier(3); // Vies du joueur
  final ValueNotifier<int> tickets = ValueNotifier(0); // Tickets accumulés

  // Le score total du joueur
  late int scoreGame;
  bool isPaused = false;
  late User _user;

  TopTeckel()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 412,
            height: 753,
          ),
        );

  double get width => 412;
  double get height => 753;
  
  final rand = math.Random();
// gestion du score
  // final ValueNotifier<int> score = ValueNotifier(0);

// Gestion des overlays en fonction de l'état du jeu
  late PlayState _playState;
  PlayState get playState => _playState;


  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      overlays.add(playState.name); // Mettre à jour les stats à la fin de la partie
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

    // Gestion de l'arrière-plan
    final dynamicBackground = DynamicBackground();
    add(dynamicBackground);

    // world de Flame représente l'univers du jeu
    world.add(PlayArea());

    playState = PlayState.welcome;
    await _loadUserData();
    
    // Initialisation du score total
    scoreGame = 0;
  }

  // Fonction pour augmenter le score
  void increaseScore() {
    if (playState == PlayState.playing) {
    score.value++;
  }
  }

  // Fonction pour perdre une vie
  void lostLife() {
    lives.value--;
    if (lives.value <= 0) {
      // Si le joueur n'a plus de vies, fin de la partie
      gameOver();
    }
  }

//   void _checkScore() {
//   if (score.value == 10) {
//     // Pause le jeu pour poser la question
//     isPaused = true;
//     // Notifier le widget parent via un callback ou un événement
//     FlameGame.notifyGameStateChanged('question');
//   }
// }

  void updateUserStatsOnGameOver() async {
  _user.scoreGame = (_user.scoreGame ?? 0) + score.value;
  _user.totalTicketsGame = (_user.totalTicketsGame ?? 0) + tickets.value;
  await Dao.updateUser(_user);
  print("Stats mises à jour : Score = ${_user.scoreGame}, Tickets = ${_user.totalTicketsGame}");
  }

void stopGameTasks() {
  // Arrêtez tous les timers, futures, ou autres tâches en cours ici
  world.removeAll(world.children.query<DogWithAccessory>());
  world.removeAll(world.children.query<GoodObject>());
  world.removeAll(world.children.query<BadObject>());
  world.removeAll(world.children.query<QuestionObject>());
}

  // Fonction de fin de partie
  void gameOver() {
    stopGameTasks();
    updateUserStatsOnGameOver();
    playState = PlayState.gameOver;
  //  // Nettoyer le monde des objets du jeu
  //   world.removeAll(world.children.query<GoodObject>());
  //   world.removeAll(world.children.query<BadObject>());
  //   world.removeAll(world.children.query<QuestionObject>());

  //   // Basculer l'état du jeu
  //   playState = PlayState.gameOver;
  //   // Sauvegarde du score actuel dans le score total
  //   // scoreGame += score.value;
  //   // Réinitialisation du score pour la prochaine partie
  //   // score.value = 0;
  }

  void pauseGame() {
    isPaused = true;
    //Arrêter les timers ou les animations ici
  }

  void resumeGame() {
    isPaused = false;
    // Reprendre les objets ou les animations ici
  }

  // Charger les données de l'utilisateur
_loadUserData() async {
  final users = await Dao.listUsers();
  if (users.isNotEmpty) {
    _user = users[0]; // Initialise l'utilisateur à partir de la base de données
    print("Utilisateur chargé : $_user");
  }
}

// l'affichage du gameplay ne se fait plus au lancement (onLoad) mais avec l'état du jeu et la fonction start
  void startGame() {

    if (playState == PlayState.playing) return;

    stopGameTasks(); // Nettoie les objets restants
  
    world.removeAll(world.children.query<DogWithAccessory>());
    // world.removeAll(world.children.query<Dog>());
    world.removeAll(world.children.query<GoodObject>());
    world.removeAll(world.children.query<BadObject>());
    world.removeAll(world.children.query<QuestionObject>());

    playState = PlayState.playing;
    
    // initialise le score à 0
    score.value = 0; // Réinitialiser le score
    lives.value = 3; // Réinitialiser les vies
    tickets.value = 0; // Réinitialiser les tickets

    // Génère un chien avec les accessoires
  final dogSprite = DogWithAccessory(
    user: _user,
    width: width,
    height: height,
  );
  // final dog = Dog(
  //   size: Vector2(dogWidth, dogHeight),
  //   position: Vector2(width / 2, height * 0.85),
  // );
  // dog.sprite = dogSprite;

  // Ajoute le chien personnalisé au monde
  world.add(dogSprite);

  print("Dog size: $dogWidth x $dogHeight");
  print("just size: $width x $dogHeight");

// Pour les objets
// Coordonnées objet spawn : 133.25 - 317.75 - 502.25 - 686.75s

// Random().nextDouble() * 256; // Value is >= 0.0 and < 256.0.
    for (var i = 0; i < 4; i++) {
      var rand = math.Random();
      double aleaTime = (rand.nextDouble() * 2) *
          1000; // durée aléatoire pour le délai entre et 0 et 1 seconde
      Future.delayed(Duration(milliseconds: aleaTime.toInt()), () {
        world.add(
          GoodObject(
              Vector2(objectZoneSpawnGap + other * i,
                  spawnHeightObjects), //écart de base + i *(largeur + ecart entre objets), hauteur de spawn de config
              // vector et vitesse à revoir
              Vector2(0, height * 0.2).normalized()..scale(height / 4)),
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
    if (playState == PlayState.gameOver) {
      // startGame(); // Redémarre le jeu si le joueur a perdu
      playState = PlayState.gameOver;
    } else {
      startGame();
    }
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
  void update(double dt) {
    if (isPaused) return;
    super.update(dt);
    //  _checkScore();
    if (playState == PlayState.gameOver) {
      return;  // Empêche la mise à jour des objets et du score
    }
    // Boucle pour chaque objet positif
    if (playState == PlayState.playing) {
    world.children.whereType<GoodObject>().forEach((objet) {
      // Augmentation de la vitesse en fonction du palier passé
      for (int unPalier in paliersDeScore) {
        if (score.value >= unPalier && !paliersAtteints.contains(unPalier)) {
          vitesseJeu = Vector2(vitesseJeu.x, vitesseJeu.y * coeffVitesse);
          objet.velocity = vitesseJeu;
          delai -=
              0.4; // Calcul de diminution -> 4 secondes de base jusqu'à max 1 sec donc 3/7 = 0.42
          paliersAtteints.add(unPalier);
        }
      }
    });
    }
  }

  
}
