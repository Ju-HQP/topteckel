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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Règles du jeu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.belanosima(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "1. Chaque joueur choisit une option : Pierre, Feuille ou Ciseaux.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "2. Les règles de base : Pierre bat Ciseaux, Ciseaux battent Feuille, Feuille bat Pierre.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "3. Le gagnant marque un point. En cas d'égalité, rejouez.",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 69, 26, 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}