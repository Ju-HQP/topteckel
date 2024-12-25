import 'package:flutter/material.dart';
import 'home_page.dart';
import 'game_page.dart';
import 'settings_page.dart';
import 'gacha_page.dart';
import 'rank_page.dart';
import 'player_profile_page.dart';
import 'signup_page.dart';
import 'waiting_page.dart';
import 'splash_screen.dart';


class GameApp extends StatelessWidget {
  // final bool userExists;
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // initialRoute: userExists ? '/home' : '/signUp',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/gameTopTeckel': (context) => const GamePage(),
        '/profile': (context) => const PlayerProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/gameGacha': (context) => const GachaPage(),
        '/rank': (context) => const RankPage(),
        '/signUp': (context) => const SignUpPage(),
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
