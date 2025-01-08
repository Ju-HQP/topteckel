import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';

class PlayerProfilePage extends StatefulWidget {
  const PlayerProfilePage({super.key});
  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage>
    with TickerProviderStateMixin {
  late User _user;
  late AnimationController _buttonController1;
  late AnimationController _buttonController2;
  bool _isPseudoValid = true;
  int? _selectedColorDog;

  @override
  void dispose() {
    _buttonController1.dispose();
    _buttonController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _buttonController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _buttonController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _loadUserData();
  }

  // Charger les données de l'utilisateur
  _loadUserData() async {
    final users = await Dao.listUsers();
    if (users.isNotEmpty) {
      setState(() {
        _user = users[0];
        _selectedColorDog = _user
            .colorDog; // Charger le premier utilisateur (on suppose qu'il y en a un)
      });
    }
  }

  // Afficher un formulaire de modification pour l'utilisateur
  _showEditDialog() {
    final pseudoController = TextEditingController(text: _user.pseudoUser);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier ton profil",
              style: GoogleFonts.belanosima(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 179, 4, 0),
              )),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          content: SizedBox(
            width: 600, // Largeur personnalisée
            height: 350, // Hauteur personnalisée
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  cursorColor: const Color.fromARGB(255, 69, 26, 28),
                  selectionControls: materialTextSelectionControls,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 69, 26, 28),
                    fontSize: 18,
                  ),
                  controller: pseudoController,
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
                    errorText:
                        !_isPseudoValid ? 'Ce champ est obligatoire' : null,
                    fillColor: Colors.white,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 69, 26, 28), width: 2.5),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Couleur du Teckel : ',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    DropdownButton<int>(
                      value: _selectedColorDog,
                      onChanged: (int? newValue) async {
                        setState(() {
                          _selectedColorDog = newValue;
                        });
                      },
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
                    ),
                  ],
                )
              ],
            ),
          ),
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
                // Mettre à jour les informations de l'utilisateur
                _user.pseudoUser = pseudoController.text;
                if (pseudoController.text.isEmpty) {
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
                _user.colorDog = _selectedColorDog;
                await Dao.updateUser(_user);
                _loadUserData();
                setState(() {
                  // Mets à jour les données de l'utilisateur et rafraîchis l'interface
                  _user.pseudoUser = pseudoController.text;
                  _user.colorDog = _selectedColorDog;
                });
                Navigator.of(context).pop();
              },
              child: Text("Enregistrer",
                  style: GoogleFonts.belanosima(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 179, 4, 0),
                  )),
            ),
          ],
        );
      },
    );
  }

  // Supprimer le compte de l'utilisateur
  _deleteAccount() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 179, 4, 0),
          title: Text(
            "Supprimer mon compte",
            style: GoogleFonts.belanosima(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: const Text(
              "Es-tu sûr de vouloir supprimer ton compte ? (Tu ne pourras plus récupérer ton compte et tes données associées)",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler",
                  style: GoogleFonts.belanosima(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
            TextButton(
              onPressed: () async {
                // Supprimer l'utilisateur de la base de données
                await Dao.deleteUser(_user.idUser!);
                Navigator.of(context).pop();
                // Rediriger l'utilisateur vers une autre page (par exemple, la page d'accueil)
                Navigator.pushReplacementNamed(context, '/signUp');
              },
              child: Text(
                "Supprimer",
                style: GoogleFonts.belanosima(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
          'Profil',
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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/decor_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Dao.listUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final users = snapshot.data as List<User>;
                if (users.isEmpty) {
                  return const Center(child: Text('Aucun utilisateur trouvé.'));
                }
                final user = users[
                    0]; // Ici, on suppose qu'il n'y a qu'un seul utilisateur
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user.pseudoUser ?? 'Utilisateur inconnu',
                          style: GoogleFonts.belanosima(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 69, 26, 28),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icon-score-topteckel.png', // Remplacez par le chemin de votre icône
                              width: 48, // Taille de l'image
                              height: 48,
                            ),
                            const SizedBox(
                                width: 8), // Espace entre l'image et le texte
                            Text(
                              user.scoreGame?.toString() ?? 'Non défini',
                              style: GoogleFonts.belanosima(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 69, 26, 28),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icon-game-gacha.png', // Remplacez par le chemin de votre icône
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              user.totalTicketsGame?.toString() ?? 'Non défini',
                              style: GoogleFonts.belanosima(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 69, 26, 28),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    _buttonController2.forward();
                                  },
                                  onTapUp: (_) async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 200));
                                    _buttonController2.reverse();
                                    _deleteAccount();
                                  },
                                  onTapCancel: () {
                                    _buttonController2.reverse();
                                  },
                                  child: AnimatedBuilder(
                                    animation: _buttonController2,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: 1.0 +
                                            (_buttonController2.value * 0.2),
                                        child: child,
                                      );
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 69, 26, 28),
                                              width: 3),
                                        ),
                                        alignment: Alignment
                                            .center, // Centrer le texte à l'intérieur du bouton
                                        child: Center(
                                          child: Text(
                                            'Fenetre question',
                                            style: GoogleFonts.belanosima(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 179, 4, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Positioned(
                          bottom:
                              20, // Position verticale identique à celle des icônes
                          left: MediaQuery.of(context).size.width / 2 -
                              80, // Centrer horizontalement
                          child: Image.asset(
                            _user.getDogImage(),
                            width:
                                150, // Taille de l'image (ajustez selon vos besoins)
                            height: 250,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    _buttonController1.forward();
                                  },
                                  onTapUp: (_) async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 200));
                                    _buttonController1.reverse();
                                    _showEditDialog();
                                  },
                                  onTapCancel: () {
                                    _buttonController1.reverse();
                                  },
                                  child: AnimatedBuilder(
                                    animation: _buttonController1,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: 1.0 +
                                            (_buttonController1.value * 0.2),
                                        child: child,
                                      );
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 179, 4, 0),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 69, 26, 28),
                                              width: 3),
                                        ),
                                        alignment: Alignment
                                            .center, // Centrer le texte à l'intérieur du bouton
                                        child: Center(
                                          child: Text(
                                            'Modifier mon profil',
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
                              ),
                              const SizedBox(
                                  width:
                                      20), // Ajouter un espace entre les boutons
                              Expanded(
                                child: GestureDetector(
                                  onTapDown: (_) {
                                    _buttonController2.forward();
                                  },
                                  onTapUp: (_) async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 200));
                                    _buttonController2.reverse();
                                    _deleteAccount();
                                  },
                                  onTapCancel: () {
                                    _buttonController2.reverse();
                                  },
                                  child: AnimatedBuilder(
                                    animation: _buttonController2,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: 1.0 +
                                            (_buttonController2.value * 0.2),
                                        child: child,
                                      );
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 69, 26, 28),
                                              width: 3),
                                        ),
                                        alignment: Alignment
                                            .center, // Centrer le texte à l'intérieur du bouton
                                        child: Center(
                                          child: Text(
                                            'Supprimer mon compte',
                                            style: GoogleFonts.belanosima(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 179, 4, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                );
              } else {
                return const Center(child: Text('Aucun utilisateur trouvé.'));
              }
            },
          ),
        ),
      ),
    );
  }
}
