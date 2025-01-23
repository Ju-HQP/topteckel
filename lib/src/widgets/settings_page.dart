import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late AnimationController _buttonController1;

  @override
  void dispose() {
    _buttonController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _buttonController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
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
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0), // Hauteur de la bordure
          child: Container(
            color:
                const Color.fromARGB(255, 69, 26, 28), // Couleur de la bordure
            height: 3.0, // Épaisseur de la bordure
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/decor_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            children: [
                Text(
                  'Règles du jeu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.belanosima(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                  "Le jeu se divise en 2 parties : Le jeu éducatif TopTeckel et le jeu Gacha.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              
              Text(
                  "1. A l'accueil : vous avez la possibilité de lancer une partie en cliquant sur 'Nouvelle partie'.\nDans la page Jeu TopTeckel : Tapez sur l'écran et lancer la partie.\nAllez le plus loin possible ! Faites grandir votre teckel en prenant les objets positifs qui tombent qui augmentent votre score total et répondez bon à des questions de culture générale pour un bonus de points à votre score et remportez des tickets pour jouer au jeu Gacha ! Apprenez tout en vous amusant !",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              
              Text(
                  "2. A la page du jeu Gacha : utilisez la machine Gacha avec un ticket Jeu Gacha en cliquant sur le bouton 'Jouer une partie'.\nRemportez un accessoire au hasard parmi les accessoires disponibles dans le jeu !\n",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              
              Text(
                  "Modifiez votre teckel dans la page Profil en lui changeant la couleur de son pelage et en lui faisant porter vos accessoires gagnés !\n",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    ));
  }
}