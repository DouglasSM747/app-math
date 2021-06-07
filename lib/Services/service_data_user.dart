import 'dart:convert';

import 'package:app_math/Struct/dataUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TypeLogin {
  Anonymous,
  GoogleLogin,
}

class ServiceDataUser {
  // CONSTRUCTOR ---------------------------------------------------------------
  static final ServiceDataUser _singleton = ServiceDataUser._internal();
  factory ServiceDataUser() => _singleton;
  ServiceDataUser._internal();
  String idUser = "";

  // VARIABLES ---------------------------------------------------------------
  DataUser mdataUser = new DataUser(userSessions: []);
  TypeLogin _mTypeLogin = TypeLogin.Anonymous;
  final _databaseReference = FirebaseDatabase.instance.reference();

  // FUNCTIONS ---------------------------------------------------------------
  loadUserData({String userId = "", required TypeLogin typeLogin}) async {
    _mTypeLogin = typeLogin;
    idUser = userId;

    if (typeLogin == TypeLogin.Anonymous) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("jsonData") == null) {
        mdataUser = _createNewDataUser(typeLogin);
        attDataUser();
      } else {
        Map<String, dynamic> map = jsonDecode(prefs.getString("jsonData")!);
        mdataUser = DataUser.fromJson(map);
      }
    }

    if (typeLogin == TypeLogin.GoogleLogin) {
      var result = await _databaseReference.child("Users").child(userId).once();
      if (result.value == null) {
        mdataUser = _createNewDataUser(typeLogin);
        attDataUser();
      } else {
        var map = Map<String, dynamic>.from(result.value);

        mdataUser.userId = map["userId"];
        mdataUser.userLastLogin = map["userLastLogin"];
        mdataUser.userTotalHours = map["userTotalHours"];
        mdataUser.pointsGeralUser = map["pointsGeralUser"];
        mdataUser.levelUser = map["levelUser"];

        if (map["userSessions"] != null) {
          List<dynamic> data = map["userSessions"];

          for (var session in data) {
            List<Question> listQuestions = new List.generate(
              0,
              (index) => new Question(),
            );

            if (session["questions"] != null) {
              for (var mapQuestion in session['questions']) {
                Question question = new Question.fromJson(
                  Map<String, dynamic>.from(mapQuestion),
                );

                listQuestions.add(question);
              }
            }

            UserSession dataSession = new UserSession(questions: listQuestions);
            dataSession.point = session['point'];
            dataSession.typeSession = session['typeSession'];
            mdataUser.userSessions.add(dataSession);
          }
        }
      }
    }
  }

  DataUser _createNewDataUser(TypeLogin typeLogin) {
    List<Question> listQuestions = List.generate(
      0,
      (index) => new Question(),
    );

    List<UserSession> listUserSessions = List.generate(
      0,
      (index) => new UserSession(questions: listQuestions),
    );

    DataUser dataUser = new DataUser(userSessions: listUserSessions);

    if (typeLogin == TypeLogin.GoogleLogin) {
      dataUser.userId = idUser;
    }
    dataUser.userLastLogin = DateTime.now().toIso8601String();
    return dataUser;
  }

  attDataUser() async {
    if (_mTypeLogin == TypeLogin.Anonymous) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("jsonData", jsonEncode(mdataUser.toJson()));
    } else {
      await _databaseReference
          .child("Users")
          .child(idUser)
          .update(mdataUser.toJson());
    }
  }
}
