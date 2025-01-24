import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topteckel/models/database/dao.dart';
import 'package:topteckel/models/question.dart';

import '../topteckel.dart';

 List<String> shuffleResponses(
      String goodResponse, List<String> badResponses) {
    final responses = [goodResponse, ...badResponses];
    responses.shuffle();
    return responses;
  }

  Future<Question> getRandomQuestion() async {

    final questions = await Dao.listQuestions();
    if (questions.isNotEmpty) {
      return questions[Random().nextInt(questions.length)];
    } else {
      throw Exception("No questions available");
    }
  }

Future<void> showQuestionModal(TopTeckel game) async {
  final question = await getRandomQuestion();
  bool isAnswered = false;
  String? selectedResponse;

  final shuffledResponses = shuffleResponses(
    question.goodResponseQuestion!,
    question.badResponsesQuestion!,
  );

  return showDialog(
    context: game.gameContext,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text(
              question.titleQuestion ?? "",
              textAlign: TextAlign.center,
              style: GoogleFonts.belanosima(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 69, 26, 28),
              ),
            ),
            content: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              // Pour chaque réponse
              children: shuffledResponses.map(
                (response) {
                  final isCorrect = response == question.goodResponseQuestion;
                  final isSelected = response == selectedResponse;

                  return ElevatedButton(
                    onPressed: isAnswered
                        ? null
                        : () {
                            setState(() {
                              selectedResponse = response;
                              isAnswered = true;
                            });
                            // Bonne réponse
                            if (isCorrect) {
                              game.tickets.value++;
                               game.increaseScore(25);
                            }
                          // Disparition de la fenêtre après l'appui
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                              game.resumeGame();
                            });
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (isAnswered) {
                            if (isSelected) {
                              return isCorrect ? Colors.green : Colors.red;
                            } else if (isCorrect) {
                              return Colors.green;
                            } else {
                              return Colors.grey;
                            }
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    child: Text(
                      response,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 69, 26, 28),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        },
      );
    },
  );
}
