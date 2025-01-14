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

  // quitter la partie
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
              "Es-tu sûr de vouloir quitter la partie ? (Les points et tickets quue tu as accumulé ne seront pas enregistré.)",
              style: TextStyle(color: Color.fromARGB(255, 179, 4, 0))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
          },
        ),
        
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(7.0), // Hauteur de la bordure
          child: Container(
            color:
                const Color.fromARGB(255, 69, 26, 28), // Couleur de la bordure
            height: 7.0, // Épaisseur de la bordure
          ),
        ),
      ),
      body: SafeArea(
            child: Center(
              child: Column(
                children: [ // affichage du score
                  Expanded(
                        child: GameWidget(
                          game: game,
                          backgroundBuilder: (context) => Container(color: Colors.transparent),
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
                ],
              ),
          ),
        ),
    );
  }
}