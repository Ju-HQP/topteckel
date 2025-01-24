import 'dart:convert';

class Question {
  int? idQuestion;
  String? titleQuestion;
  String? goodResponseQuestion;
  List<String>? badResponsesQuestion;

  Question({this.idQuestion, this.titleQuestion, this.goodResponseQuestion, this.badResponsesQuestion});

  Question.fromJson(Map<String, dynamic> json) {
    idQuestion = json["id_question"];
    titleQuestion = json["title_question"];
    goodResponseQuestion = json["good_response_question"];
    // Décodage JSON pour transformer en liste
    badResponsesQuestion = List<String>.from(jsonDecode(json["bad_responses_question"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id_question": idQuestion,
      "title_question": titleQuestion,
      "good_response_question": goodResponseQuestion,
      "bad_responses_question": jsonEncode(badResponsesQuestion),
    };
  }
}
