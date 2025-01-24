import 'package:flutter/material.dart';
import 'package:topteckel/src/widgets/overlay_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CountdownOverlay extends StatefulWidget {
  final VoidCallback onCountdownComplete;

  const CountdownOverlay({super.key, required this.onCountdownComplete});

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay> {
  int countdown = 3;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() async {
    // Boucle pour le compteur, avec une seconde entre chaque itération
    for (int i = 3; i > 0; i--) {
      setState(() {
        countdown = i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }

    // Dernière étape : afficher "Go!" puis appeler le callback
    setState(() {
      countdown = 0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    widget.onCountdownComplete();
  }

  @override
  Widget build(BuildContext context) {
    final text = countdown > 0 ? countdown.toString() : 'Go!';
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: countdown > 0 ? Colors.white : Colors.green,
            ),
      ).animate().scale(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }
}
