import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/accessoryProperties.dart';
import 'package:topteckel/src/components/gachaGame.dart';


class GachaPage extends StatefulWidget {
  // final User user;

  const GachaPage({super.key});

  @override
  _GachaPageState createState() => _GachaPageState();
}

class _GachaPageState extends State<GachaPage> with TickerProviderStateMixin{
  bool _isLoading = false;
  String _resultMessage = "";
  late User _user;
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
    _loadUserData();
  }

  _loadUserData() async {
    final users = await Dao.listUsers();
    if (users.isNotEmpty) {
      setState(() {
        _user = users[0];
      });
    } else {
    _showResultDialog("Aucun utilisateur trouvé !");
  }
  }
  void _performDraw() async {
    
    setState(() {
      _isLoading = true;
    });

    // Appeler la méthode de tirage
    String result = await GachaGame.drawAccessory(_user);

    setState(() {
      _isLoading = false;
      _resultMessage = result;
    });

    // Afficher le résultat dans une boîte de dialogue
    _showResultDialog(result);
  }

  void _showResultDialog(String result) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Résultat du tirage",
        textAlign: TextAlign.center,
        style: GoogleFonts.belanosima(
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 179, 4, 0),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Adapte la hauteur au contenu
        children: [
          Text(
            result,
            textAlign: TextAlign.center, // Centre le texte du résultat
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 69, 26, 28),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center, // Centre les boutons
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
            style: TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 69, 26, 28),
            ),
          ),
        ),
      ],
    ),
  );
}
      
      // builder: (context) => AlertDialog(
      //   title: const Text("Résultat du tirage"),
      //   content: Text(result),
      //   actions: [
      //     TextButton(
      //       onPressed: () => Navigator.pop(context),
      //       child: const Text("OK"),
      //     ),
      //   ],
      // ),
     

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jeu Gacha', 
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
            color: const Color.fromARGB(
                            255, 69, 26, 28), // Couleur de la bordure
            height: 3.0, // Épaisseur de la bordure
          ),
        ),
      ),
      body: Stack(
      children: [
        // Fond avec décor
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/decor_gacha2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Score total des tickets
        Positioned(
          top: 25,
          right:25,
          child: Row(
            children: [
              Image.asset(
                'assets/images/icon-game-gacha.png',
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 8),
              Text(
                _user.totalTicketsGame?.toString() ?? 'Non défini',
                style: GoogleFonts.belanosima(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 69, 26, 28),
                ),
              ),
            ],
          ),
        ),
        // Contenu principal
        Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 179, 4, 0),
                  color: Color.fromARGB(255, 69, 26, 28),)
              :Align(
  alignment: const Alignment(0, 0.4), // Place le bouton en bas
  child: GestureDetector(
    onTapDown: (_) {
      _buttonController1.forward();
    },
    onTapUp: (_) async {
      await Future.delayed(const Duration(milliseconds: 200));
      _buttonController1.reverse();
      _performDraw();
    },
    onTapCancel: () {
      _buttonController1.reverse();
    },
    child: AnimatedBuilder(
      animation: _buttonController1,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_buttonController1.value * 0.2),
          child: child,
        );
      },
      child: SizedBox(
        width: 170, // Largeur explicite du bouton
        height: 80, // Hauteur explicite du bouton
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20, // Ajuster la marge intérieure horizontale
            vertical: 10,   // Ajuster la marge intérieure verticale
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 179, 4, 0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color.fromARGB(255, 69, 26, 28), width: 3),
          ),
          alignment: Alignment.center,
          child: Text(
            'Jouer à une partie',
            textAlign: TextAlign.center,
            style: GoogleFonts.belanosima(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  ),
),
              // : ElevatedButton(
              //     onPressed: _user == null ? null : _performDraw,
              //     child: const Text("Tirer un accessoire", TextStyle),
              //   ),
              
        ),
      ],
    ),
    );
  }}