class User {
  int? idUser;
  String? pseudoUser;
  DateTime? dateGame;
  int? scoreGame;
  int? totalTicketsGame;
  int? colorDog;

  User({this.idUser, this.pseudoUser, this.dateGame, this.scoreGame, this.totalTicketsGame, this.colorDog});

  User.fromJson(Map<String, dynamic> json) {
  idUser = json["id_user"] ?? 0; // Assurez-vous d'avoir une valeur par défaut
  pseudoUser = json["pseudo_user"] ?? '';
  dateGame = json["date_game"] != null ? DateTime.tryParse(json["date_game"]) : null;
  scoreGame = json["score_game"] ?? 0;
  totalTicketsGame = json["total_tickets_game"] ?? 0;
  colorDog = json["color_dog"] ?? 0;
}

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id_user"] = idUser;
    map["pseudo_user"] = pseudoUser;
    map["date_game"] = dateGame?.toIso8601String();
    map["score_game"] = scoreGame;
    map["total_tickets_game"] = totalTicketsGame;
    map["color_dog"] = colorDog;
    return map;
  }

  String getDogImage() {
    switch (colorDog) {
      case 1:
        return 'assets/images/teckel_1.png';
      case 2:
        return 'assets/images/teckel_2.png';
      case 3:
        return 'assets/images/teckel_3.png';
      case 4:
        return 'assets/images/teckel_4.png';
      default:
        return 'assets/images/teckel_1.png'; // Valeur par défaut si aucune couleur n'est définie
    }
  }
}
