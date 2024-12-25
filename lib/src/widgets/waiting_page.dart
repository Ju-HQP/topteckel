import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/decor_home.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 179, 4, 0),
                  color: Color.fromARGB(255, 69, 26, 28),
                ),
                const SizedBox(height: 20),
                Text(
                  "Chargement...",
                  style: GoogleFonts.belanosima(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 69, 26, 28), // Texte lisible sur un fond coloré
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
    );
  }
}
