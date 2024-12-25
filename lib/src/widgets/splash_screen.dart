// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'game_app.dart';
// import 'signup_page.dart';
// import 'waiting_page.dart';
// import '../../models/database/dao.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   Future<bool> checkUserExists() async {
//     try {
//       await Future.delayed(const Duration(seconds: 5)); // Simule un délai
//       return await Dao.userExists(); // Vérifie l'utilisateur
//     } catch (e) {
//       throw Exception('Erreur lors de la vérification de l\'utilisateur: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: checkUserExists(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Pendant le chargement, affiche la WaitingPage
//           return const WaitingPage();
//         } else if (snapshot.hasError) {
//           // En cas d'erreur, affiche un message d'erreur
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error, size: 50, color: Colors.red),
//                 const SizedBox(height: 16),
//                 Text('Erreur : ${snapshot.error}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 18)),
//               ],
//             ),
//           );
//         } else if (snapshot.data == true) {
//           // Si l'utilisateur existe, navigue vers GameApp avec userExists = true
//           return const GameApp(userExists: true);
//         } else {
//           // Sinon, navigue vers la page d'inscription
//           return const SignUpPage();
//         }
//       },
//     );
//   }
// }
