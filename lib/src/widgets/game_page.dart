import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:topteckel/src/widgets/countDown_overlay.dart';
import '../topteckel.dart';
import 'overlay_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final TopTeckel game;

  @override
  void initState() {
    super.initState();
    game = TopTeckel(gameContext: context);
  }

// suppression totale du jeu (cette classe ne sera plus rebuild)
  @override
  void dispose() {
    game.pauseGame();
    super.dispose();
  }

  // Fenêtre -> Quitter la partie
  _quitGame() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Quitter la partie",
            textAlign: TextAlign.center,
            style: GoogleFonts.belanosima(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 179, 4, 0),
            ),
          ),
          content: const Text(
              "Es-tu sûr de vouloir quitter la partie ? (Les points et tickets que tu as accumulé ne seront pas enregistré.)",
              style: TextStyle(color: Color.fromARGB(255, 179, 4, 0))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                game.resumeGame();
              },
              child: Text("Annuler",
                  style: GoogleFonts.belanosima(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 179, 4, 0),
                  )),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                game.onRemove();
                // Rediriger l'utilisateur vers une autre page (par exemple, la page d'accueil)
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                "Quitter la partie",
                style: GoogleFonts.belanosima(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 179, 4, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher la fenêtre de fin de partie
  _showGameOverDialog() {
    if (game.isEnded()) {
      showDialog(
        context: context,
        builder: (context) {
          game.chgEnded();
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Perdu !',
              textAlign: TextAlign.center,
              style: GoogleFonts.belanosima(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 179, 4, 0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centrer le contenu
                      children: [
                        Image.asset(
                          'assets/images/icon-score-topteckel.png',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Score obtenu : ${(game.score.value)}",
                          style: GoogleFonts.belanosima(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 69, 26, 28),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Espacement entre les lignes
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centrer le contenu
                      children: [
                        Image.asset(
                          'assets/images/icon-game-gacha.png',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Tickets obtenus : ${(game.tickets.value)}",
                          style: GoogleFonts.belanosima(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 69, 26, 28),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        game.updateUserStatsOnGameOver;
                        game.playState = PlayState.welcome;
                        game.onRemove();
                        Navigator.pushReplacementNamed(
                            context, '/home'); // Revenir à l'accueil
                      },
                      child: Text(
                        "Retour à l'accueil",
                        style: GoogleFonts.belanosima(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 179, 4, 0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        game.updateUserStatsOnGameOver();
                        Navigator.of(context).pop(); // Fermer la fenêtre
                        game.startGame(); // Redémarrer le jeu
                      },
                      child: Text(
                        "Rejouer",
                        style: GoogleFonts.belanosima(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 179, 4, 0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Jeu TopTeckel',
            style: GoogleFonts.belanosima(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 179, 4, 0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _quitGame();
              game.pauseGame();
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(7.0), // Hauteur de la bordure
            child: Container(
              color: const Color.fromARGB(
                  255, 69, 26, 28), // Couleur de la bordure
              height: 7.0, // Épaisseur de la bordure
            ),
          ),
        ),
        body: SafeArea(
            child: Stack(children: [
          // Jeu
          Positioned.fill(
            child: GameWidget(
              game: game,
              backgroundBuilder: (context) =>
                  Container(color: Colors.transparent),
              overlayBuilderMap: {
                PlayState.welcome.name: (context, game) => const OverlayScreen(
                      title: "Tape l'écran pour jouer",
                      subtitle: 'Utilise ton doigt',
                    ),
                PlayState.gameOver.name: (context, game) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showGameOverDialog();
                  });
                  return const SizedBox.shrink();
                },
                PlayState.countDown.name: (context, TopTeckel game) {
                  return CountdownOverlay(
                    onCountdownComplete: () {
                      // Passez à l'état `playing` après le décompte
                      game.playState = PlayState.playing;
                    },
                  );
                }
              },
            ),
          ),
          // Score, Vies, Tickets
          Positioned(
            top: 10, // Positionnement en haut
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Score
                ValueListenableBuilder<int>(
                  valueListenable: game.score,
                  builder: (context, score, child) {
                    return Row(
                      children: [
                        Image.asset(
                          'assets/images/icon-score-topteckel.png',
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Score: $score',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 69, 26, 28)),
                        ),
                      ],
                    );
                  },
                ),
                // Tickets
                ValueListenableBuilder<int>(
                  valueListenable: game.tickets,
                  builder: (context, tickets, child) {
                    return Row(
                      children: [
                        Image.asset(
                          'assets/images/icon-game-gacha.png',
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tickets: $tickets',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 69, 26, 28)),
                        ),
                      ],
                    );
                  },
                ),
                // Vies
                ValueListenableBuilder<int>(
                  valueListenable: game.lives,
                  builder: (context, lives, child) {
                    return Row(
                      children: [
                        const Icon(Icons.favorite,
                            size: 26, color: Color.fromARGB(255, 179, 4, 0)),
                        const SizedBox(width: 8),
                        Text(
                          'Vies: $lives',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 69, 26, 28)),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ])));
  }
}
