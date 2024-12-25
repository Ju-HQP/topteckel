import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const _iconSizeSmall = 60.0;
  static const _iconSizeLarge = 70.0;
  static const _animationDuration = Duration(milliseconds: 100);

  // Map pour gérer l'état des tailles de chaque icône
  final Map<String, AnimationController> _controllers = {};
  late AnimationController _buttonController;
  
  @override
  void initState() {
    super.initState();
    // Initialisation des AnimationControllers pour chaque icône
    _controllers['rank'] = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controllers['profile'] = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controllers['settings'] = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controllers['gacha'] = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // AnimationController pour le bouton
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/decor_default2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            _buildAnimatedIcon(
              context,
              routeName: '/profile',
              imagePath: 'assets/images/icon_profile.png',
              key: 'profile',
              position: Alignment.topLeft, // Haut gauche
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 2 -
              170, // Position verticale identique à celle des icônes
              left: MediaQuery.of(context).size.width / 2 -
              140, // Centrer horizontalement
              child: Image.asset(
                'assets/images/logo_topteckel.png',
                width: 300, // Taille de l'image (ajustez selon vos besoins)
                height: 300,
              ),
            ),
            _buildAnimatedIcon(
              context,
              routeName: '/rank',
              imagePath: 'assets/images/icon_rank.png',
              key: 'rank',
              position: Alignment.topRight, // Haut droite
            ),
            _buildAnimatedIcon(
              context,
              routeName: '/gameGacha',
              imagePath: 'assets/images/icon_gacha.png',
              key: 'gacha',
              position: Alignment.bottomLeft, // Bas gauche
            ),
            _buildAnimatedIcon(
              context,
              routeName: '/settings',
              imagePath: 'assets/images/icon_settings.png',
              key: 'settings',
              position: Alignment.bottomRight, // Bas droite
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 60,
              left: MediaQuery.of(context).size.width / 2 - 120,
              child: GestureDetector(
                onTapDown: (_) {
                  _buttonController.forward(); // Démarre l'animation
                },
                onTapUp: (_) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _buttonController.reverse(); // Revenir à l'état initial
                    Navigator.pushNamed(context, '/gameTopTeckel');
                  });
                },
                onTapCancel: () {
                  _buttonController.reverse();
                },
                child: AnimatedBuilder(
                  animation: _buttonController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_buttonController.value * 0.2),
                      child: child,
                    );
                  },
                  child: ElevatedButton(
                    onPressed: () {Navigator.pushNamed(context, '/gameTopTeckel');}, // Géré par GestureDetector
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(255, 179, 4, 0),
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 69, 26, 28), // Couleur de la bordure
                        width: 3, // Épaisseur de la bordure
                      ),
                    ),
                    child: Text(
                      'Nouvelle partie',
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
            Positioned(
              bottom: 20, // Position verticale identique à celle des icônes
              left: MediaQuery.of(context).size.width / 2 -
                  80, // Centrer horizontalement
              child: Image.asset(
                'assets/images/teckel_default.png',
                width: 150, // Taille de l'image (ajustez selon vos besoins)
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Méthode pour créer un widget d'icône animé
  Widget _buildAnimatedIcon(
    BuildContext context, {
    required String routeName,
    required String imagePath,
    required String key,
    required Alignment position,
  }) {
    // final bool isExpanded = _isExpanded[key] ?? false;

    return Positioned(
      left: position == Alignment.topLeft || position == Alignment.bottomLeft
          ? 20
          : null,
      right: position == Alignment.topRight || position == Alignment.bottomRight
          ? 20
          : null,
      top: position == Alignment.topLeft || position == Alignment.topRight
          ? 40
          : null,
      bottom:
          position == Alignment.bottomLeft || position == Alignment.bottomRight
              ? 20
              : null,
      child: GestureDetector(
        onTapDown: (_) {
          _controllers[key]!
              .forward(); // Démarre l'animation pour l'icône spécifique
        },
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 200), () {
            _controllers[key]!.reverse(); // Retourne l'icône à l'état initial
            Navigator.pushNamed(context, routeName);
          });
        },
        onTapCancel: () {
          _controllers[key]!.reverse();
        },
        child: AnimatedBuilder(
          animation: _controllers[key]!,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 +
                  (_controllers[key]!.value *
                      0.2), // Ajuste la taille lors de l'animation
              alignment: Alignment.center, // Point d'ancrage de l'animation
              child: child,
            );
          },
          child: Image.asset(
            imagePath,
            width: 70,
            height: 70,
          ),
        ),
      ),
    );
  }
}
