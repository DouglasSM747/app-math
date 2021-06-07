import 'dart:convert';

DataUser dataUserFromJson(String str) => DataUser.fromJson(json.decode(str));

String dataUserToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
  DataUser({
    this.userId = "0",
    this.levelUser = 0,
    this.userLastLogin = "0",
    this.pointsGeralUser = 0,
    this.userTotalHours = 120,
    required this.userSessions,
  });

  String userId;
  String userLastLogin;
  int levelUser;
  int pointsGeralUser;
  int userTotalHours;
  List<UserSession> userSessions;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        userId: json["userId"],
        levelUser: json["levelUser"],
        pointsGeralUser: json["pointsGeralUser"],
        userLastLogin: json["userLastLogin"],
        userTotalHours: json["userTotalHours"],
        userSessions: json["userSessions"] != null
            ? List<UserSession>.from(
                json["userSessions"].map((x) => UserSession.fromJson(x)),
              )
            : List.generate(0, (index) => new UserSession(questions: [])),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "levelUser": levelUser,
        "userLastLogin": userLastLogin,
        "pointsGeralUser": pointsGeralUser,
        "userTotalHours": userTotalHours,
        "userSessions": List<dynamic>.from(userSessions.map((x) => x.toJson())),
      };
}

class UserSession {
  UserSession({
    this.typeSession = "",
    this.point = 10,
    required this.questions,
  });

  String typeSession;
  int point;
  List<Question> questions;

  factory UserSession.fromJson(Map<String, dynamic> json) => UserSession(
        typeSession: json["typeSession"],
        point: json["point"],
        questions: json["questions"] == null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : List.generate(0, (index) => new Question()),
      );

  Map<String, dynamic> toJson() => {
        "typeSession": typeSession,
        "point": point,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.enunQuestion = "",
    this.selectedResult = "",
    this.typeQuestion = "",
    this.correct = false,
  });

  String enunQuestion;
  String selectedResult;
  bool correct;
  String typeQuestion;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        enunQuestion: json["enunQuestion"],
        typeQuestion: json["typeQuestion"],
        selectedResult: json["selectedResult"],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
        "enunQuestion": enunQuestion,
        "typeQuestion": typeQuestion,
        "selectedResult": selectedResult,
        "correct": correct,
      };
}
