import 'dart:async';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/question.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/dogWithAccessory.dart';
import 'package:topteckel/src/widgets/questionWindow.dart';

import 'components/components.dart';
import 'config.dart';

// Fichier principal de coordination du jeu

// états du jeu
enum PlayState { welcome, playing, countDown, gameOver }

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
  late BuildContext gameContext;
  // Gérer la fenêtre d'apparition de GameOver
  bool ended = false;

  TopTeckel({required this.gameContext})
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

// Permet de ne jamais superposer 2 overlays
    overlays.clear();

    switch (playState) {
      case PlayState.welcome:
        overlays.add(playState.name);
        break;
      case PlayState.gameOver:
        overlays.add(playState.name);
        break; // Mettre à jour les stats à la fin de la partie
      case PlayState.countDown:
        overlays.add(playState.name);
        break;
      case PlayState.playing:
        break;
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
  void increaseScore([double? value]) {
    if (playState == PlayState.playing) {
      if (value != null) {
        score.value += value.toInt();
      } else {
        score.value++;
      }
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
    print(
        "Stats mises à jour : Score = ${_user.scoreGame}, Tickets = ${_user.totalTicketsGame}");
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
    ended = true;
    stopGameTasks();
    updateUserStatsOnGameOver();
    pauseGame();
    playState = PlayState.gameOver;
  }

  void gameQuestion() {
    pauseGame();
    showQuestionModal(this);
  }

  bool isEnded() {
    return ended;
  }

  chgEnded() {
    ended = false;
  }

  void pauseGame() {
    isPaused = true;
    //Arrêter les timers ou les animations ici
  }

  void resumeGame() {
    playState = PlayState.countDown;
    Future.delayed(const Duration(milliseconds: 3000), () {
      playState = PlayState.playing;
      isPaused = false;
    });
    // Reprendre les objets ou les animations ici
  }

  @override
  void onRemove() {
    // Optional based on your game needs.
    removeAll(children);
    processLifecycleEvents();
  }

  // Charger les données de l'utilisateur
  _loadUserData() async {
    final users = await Dao.listUsers();
    if (users.isNotEmpty) {
      _user =
          users[0]; // Initialise l'utilisateur à partir de la base de données
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
        double newrand = rand.nextDouble();
        // Créer un nouvel objet
        switch (newrand) {
          case < 0.05:
            world.add(
              QuestionObject(
                  Vector2(objectZoneSpawnGap + other * i, spawnHeightObjects),
                  vitesseJeu),
            );
            break;
          case < 0.35:
            world.add(
              BadObject(
                  Vector2(objectZoneSpawnGap + other * i, spawnHeightObjects),
                  vitesseJeu),
            );
            break;
          case <= 1:
            world.add(
              GoodObject(
                  Vector2(objectZoneSpawnGap + other * i, spawnHeightObjects),
                  vitesseJeu),
            );
            break;
        }
      });
    }

    // Active le mode debug pour l'ensemble des composants
    debugMode = true;
  }

// Gestion de l'interaction d'Appui
  @override
  void onTap() {
    super.onTap();
    if (playState == PlayState.countDown || playState == PlayState.gameOver) {
      return;
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
    if (playState == PlayState.gameOver || playState == PlayState.countDown) {
      return; // Empêche la mise à jour des objets et du score
    }
    // Boucle pour chaque objet positif
    if (playState == PlayState.playing) {
      world.children.whereType<Object>().forEach((objet) {
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
