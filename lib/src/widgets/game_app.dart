import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'game_page.dart';
import 'settings_page.dart';
import 'player_profile_page.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/gameTopTeckel': (context) => const GamePage(),
        '/profile': (context) => const PlayerProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class BackgroundPage extends StatelessWidget {
  final Widget child;

  const BackgroundPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/decor_default.png'), // Ton image ici
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: child), // Ton contenu (page) ici
      ),
    );
  }
}
