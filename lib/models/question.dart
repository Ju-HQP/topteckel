class Question {
  int? idQuestion;
  String? titleQuestion;
  String? goodResponseQuestion;
  String? badResponsesQuestion;

  Question({this.idQuestion, this.titleQuestion, this.goodResponseQuestion, this.badResponsesQuestion});

  Question.fromJson(Map<String, dynamic> json) {
    idQuestion = json["id_question"];
    titleQuestion = json["title_question"];
    goodResponseQuestion = json["good_response_question"];
    badResponsesQuestion = json["bad_responses_question"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id_question"] = idQuestion;
    map["title_question"] = titleQuestion;
    map["good_response_question"] = goodResponseQuestion;
    map["bad_responses_question"] = badResponsesQuestion;
    return map;
  }
}
