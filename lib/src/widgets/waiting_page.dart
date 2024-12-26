import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPage extends StatefulWidget {
  final bool userExists;
  const WaitingPage({super.key, required this.userExists});
  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulation de chargement

    if (widget.userExists) {
      Navigator.pushReplacementNamed(context, '/home'); // Va vers HomePage
    } else {
      Navigator.pushReplacementNamed(context, '/signUp'); // Va vers SignUpPage
    }
  }
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
