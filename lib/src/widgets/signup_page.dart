import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/widgets/home_page.dart';
import 'package:topteckel/src/widgets/game_app.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final TextEditingController _pseudoController = TextEditingController();
  late AnimationController _buttonController;
  int _colorDog = 1; // Valeur par défaut

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
    final newUser = User(
      pseudoUser: _pseudoController.text,
      passwordUser:
          'password', // Ajouter un mot de passe par défaut ou demandez-le à l'utilisateur
      dateGame: DateTime.now(),
      scoreGame: 0,
      totalTicketsGame: 0,
      colorDog: _colorDog,
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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Champ de texte pour le pseudo
                  TextField(
                    controller: _pseudoController,
                    decoration: const InputDecoration(
                      labelText: 'Pseudo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Liste déroulante pour la couleur
                  DropdownButtonFormField<int>(
                    value: _colorDog,
                    decoration: const InputDecoration(
                      labelText: 'Choisir une couleur',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Couleur 1')),
                      DropdownMenuItem(value: 2, child: Text('Couleur 2')),
                      DropdownMenuItem(value: 3, child: Text('Couleur 3')),
                      DropdownMenuItem(value: 4, child: Text('Couleur 4')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _colorDog = value ?? 1;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Bouton rouge personnalisé

                  ElevatedButton(
                    onPressed: () async {
                      // Animation de l'élément du bouton
                      await _buttonController.forward(); // Démarre l'animation
                      await Future.delayed(const Duration(milliseconds: 200));
                      _buttonController.reverse(); // Revenir à l'état initial

                      // Création de l'utilisateur
                      _createUser(); // Crée l'utilisateur et navigue vers HomePage
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(255, 179, 4, 0),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 69, 26, 28),
                        width: 3, // Épaisseur de la bordure
                      ),
                    ),
                    child: AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 +
                              (_buttonController.value *
                                  0.2), // Animation de la taille
                          child: child,
                        );
                      },
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
                  // ElevatedButton(
                  //             onPressed: _createUser,
                  //             child: const Text('Créer le profil'),
                  //           ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
