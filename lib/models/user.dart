class User {
  int? idUser;
  String? pseudoUser;
  String? passwordUser;
  DateTime? dateGame;
  int? scoreGame;
  int? totalTicketsGame;
  int? colorDog;

  User({this.idUser, this.pseudoUser, this.passwordUser, this.dateGame, this.scoreGame, this.totalTicketsGame, this.colorDog});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    pseudoUser = json["pseudo_user"];
    passwordUser = json["password_user"];
    dateGame = json["date_game"] != null ? DateTime.parse(json["date_game"]) : null;
    scoreGame = json["score_game"];
    totalTicketsGame = json["total_tickets_game"];
    colorDog = json["color_dog"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id_user"] = idUser;
    map["pseudo_user"] = pseudoUser;
    map["password_user"] = passwordUser;
    map["date_game"] = dateGame;
    map["score_game"] = scoreGame;
    map["total_tickets_game"] = totalTicketsGame;
    map["color_dog"] = colorDog;
    return map;
  }
}
