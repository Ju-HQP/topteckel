import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/user.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

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
            color: const Color.fromARGB(
                            255, 69, 26, 28), // Couleur de la bordure
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

        child: FutureBuilder(
  future: Dao.listUsers(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Erreur : ${snapshot.error}'));
    } else if (snapshot.hasData) {
      final users = snapshot.data as List<User>;
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.pseudoUser ?? 'Utilisateur inconnu'),
            subtitle: Text(
            'Score : ${user.scoreGame?.toString() ?? 'Non défini'}\n'
            'Tickets : ${user.totalTicketsGame?.toString() ?? 'Non défini'}',
            ),
          );
        },
      );
    } else {
      return const Center(child: Text('Aucun utilisateur trouvé.'));
    }
  },
)

      ),
    );
  }
}