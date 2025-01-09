import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../topteckel.dart';
import '../config.dart';
import 'overlay_screen.dart';
import 'score_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';

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
    game = TopTeckel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Jeu TopTeckel',
      //     style: GoogleFonts.belanosima(
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   backgroundColor: const Color.fromARGB(255, 179, 4, 0),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(3.0), // Hauteur de la bordure
      //     child: Container(
      //       color:
      //           const Color.fromARGB(255, 69, 26, 28), // Couleur de la bordure
      //       height: 3.0, // Épaisseur de la bordure
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/decor_default.png'),
            fit: BoxFit.cover, // Ajuste l'image pour couvrir tout l'écran
          ),
        ),
        // child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [ // affichage du score
                  ScoreCard(score: game.score),
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'TAP TO PLAY',
                                  subtitle: 'Use arrow keys or swipe',
                                ),
                            PlayState.gameOver.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'G A M E   O V E R',
                                  subtitle: 'Tap to Play Again',
                                ),
                            PlayState.won.name: (context, game) =>
                                const OverlayScreen(
                                  title: 'Y O U   W O N ! ! !',
                                  subtitle: 'Tap to Play Again',
                                ),
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        // ),
      ),
    );
  }
}