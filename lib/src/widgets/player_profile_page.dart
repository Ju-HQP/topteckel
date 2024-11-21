import 'package:flutter/material.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil du joueur'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: const Text('Informations du joueur'),
      ),
    );
  }
}