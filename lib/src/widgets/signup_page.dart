import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/widgets/home_page.dart';
import 'package:topteckel/src/widgets/game_app.dart';

class SignUpPage extends StatefulWidget {
  // final User user;
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final TextEditingController _pseudoController = TextEditingController();
  late AnimationController _buttonController;
  int _colorDog = 1; // Valeur par défaut
  bool _isPseudoValid = true;

  @override
  void dispose() {
    _pseudoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialisation du AnimationController pour le bouton
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  // Fonction pour créer un utilisateur
  void _createUser() async {
    if (_pseudoController.text.isEmpty) {
      setState(() {
        _isPseudoValid = false; // Afficher le message d'erreur
      });
    // Afficher un message d'erreur si le champ est vide
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Le pseudo est obligatoire !'),
        backgroundColor: Colors.red,
      ),
    );
    return; // Arrêter la création si le pseudo est vide
  }

    final newUser = User(
      pseudoUser: _pseudoController.text,
      dateGame: DateTime.now(),
      scoreGame: 0,
      totalTicketsGame: 3,
      colorDog: _colorDog,
      accessory: 'chapeau-TopTeckel',
      accessoriesList: ["chapeau-TopTeckel"],
    );
    await Dao.createUser(newUser);
    // Navigator.pushReplacementNamed(context, '/home');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Création de votre compte",
          style: GoogleFonts.belanosima(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: const Color.fromARGB(255, 179, 4, 0),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0), // Hauteur de la bordure
          child: Container(
            color:
                const Color.fromARGB(255, 69, 26, 28), // Couleur de la bordure
            height: 3.0, // Épaisseur de la bordure
          ),
        ),
      ),
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/decor_home.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu au centre de la page
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_topteckel.png',
                    width: 300, // Taille de l'image
                    height: 300,
                  ),

                  const SizedBox(height: 10),
                  // Champ de texte pour le pseudo
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Ajoute 20 pixels à gauche et à droite
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 69, 26, 28),
                      selectionControls: materialTextSelectionControls,
                      controller: _pseudoController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 69, 26, 28),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 69, 26, 28),
                                width: 2.0)),
                        labelText: 'Pseudo',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 69, 26, 28),
                        ),
                        errorText: !_isPseudoValid
                        ? 'Ce champ est obligatoire'
                        : null, // Message d'erreur dynamique
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 69, 26, 28),
                              width: 2.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Liste déroulante pour la couleur
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal:
                            20.0), // Ajoute 20 pixels à gauche et à droite
                    child: DropdownButtonFormField<int>(
                      value: _colorDog,
                      dropdownColor: const Color.fromARGB(255, 180, 231, 255),
                      icon: const Icon(
                        Icons.arrow_drop_down, // Icône personnalisée
                        color: Color.fromARGB(
                            255, 69, 26, 28), // Couleur de la flèche
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Choisir une couleur',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 69, 26, 28), // Couleur du label
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 69, 26, 28),
                                width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 69, 26, 28),
                              width: 2.5), // Bordure au focus
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(
                            255, 69, 26, 28), // Couleur du texte sélectionné
                      ),
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/icon-color-teckel_1.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacement entre l'image et le texte
                              Text('Couleur 1'),
                            ],
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/icon-color-teckel_2.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacement entre l'image et le texte
                              Text('Couleur 2'),
                            ],
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/icon-color-teckel_3.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacement entre l'image et le texte
                              Text('Couleur 3'),
                            ],
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 4,
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/icon-color-teckel_4.png'),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                  width:
                                      10), // Espacement entre l'image et le texte
                              Text('Couleur 4'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _colorDog = value ?? 1;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                
                  // Bouton rouge personnalisé
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        // Animation au toucher
                        onTapDown: (_) {
                          _buttonController.forward(); // Démarre l'animation
                        },
                        onTapUp: (_) async {
                          // Ajoute un léger délai pour laisser l'animation se jouer
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          _buttonController
                              .reverse(); // Revenir à l'état initial

                          // Création de l'utilisateur après l'animation
                          _createUser();
                        },
                        onTapCancel: () {
                          _buttonController
                              .reverse(); // Annule l'animation si le toucher est interrompu
                        },

                        // Animation sur tout le bloc
                        child: AnimatedBuilder(
                          animation: _buttonController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_buttonController.value * 0.2),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            // Ajout du conteneur avec fond
                            width: 240,
                            child:Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 179, 4, 0), // Couleur de fond
                              borderRadius:
                                  BorderRadius.circular(12), // Coins arrondis
                              border: Border.all(
                                // Bordure
                                color: const Color.fromARGB(255, 69, 26, 28),
                                width: 3,
                              ),
                            ),
                            // Bouton stylisé
                            alignment: Alignment.center,
                            child: Text(
                              'Créer un profil',
                              style: GoogleFonts.belanosima(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
