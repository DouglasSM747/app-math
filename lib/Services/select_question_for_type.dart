import 'dart:math';

import 'package:app_math/Pages/game.dart';
import 'package:app_math/Services/service_question_MMC_MDC.dart';
import 'package:app_math/Services/service_question_MediaMedianaModa.dart';
import 'package:app_math/Services/service_question_expoentes.dart';
import 'package:app_math/Services/service_question_number_prime.dart';
import 'package:app_math/Services/service_question_regraDeTres.dart';
import 'package:app_math/Struct/structs.dart';

class SelectTypeQuestions {
  final type_game _gameType;

  SelectTypeQuestions(this._gameType);

  List<QuestionStruct> getListQuestions() {
    if (_gameType == type_game.DIVERSOS) {
      return _typeQuestionsDiversos();
    } else if (_gameType == type_game.Q_CONJUNTOS) {
      // * GERANDO ATIVIDADES EXPOENTES
      return new List.generate(
        20,
        (index) => new GenerateQuestionExpoentes().generateQuestionExpoentes(),
      );
    } else if (_gameType == type_game.Q_EXPOENTES) {
      // * GERANDO ATIVIDADES EXPOENTES
      return new List.generate(
        20,
        (index) => new GenerateQuestionExpoentes().generateQuestionExpoentes(),
      );
    } else if (_gameType == type_game.Q_MEDIA_MEDIANA_INTERVALO) {
      // * GERANDO ATIVIDADES MEDIA MEDIANA INTERVALO
      return new List.generate(
        20,
        (index) => new GenerateQuestionMedia().generateQuestioMedia(),
      );
    } else if (_gameType == type_game.Q_MMC_MDC) {
      // * GERANDO ATIVIDADES MMC E MDC
      return new List.generate(
        20,
        (index) => new GenerateQuestionMMCeMDC().generateQuestionMMCeMDC(),
      );
    } else if (_gameType == type_game.Q_NUMBER_PRIME) {
      // * GERANDO ATIVIDADES NUMERO PRIMO
      return new List.generate(
        20,
        (index) => new GenerateQuestionNumberPrime().generateQuestionPrime(),
      );
    } else if (_gameType == type_game.Q_REGRA_TRES) {
      // * GERANDO ATIVIDADES REGRA DE TRES
      return new List.generate(
        20,
        (index) =>
            new GenerateQuestionRegraDeTres().generateQuestionRegraDeTres(),
      );
    } else {
      return new List.generate(0, (index) => new QuestionStruct());
    }
  }

  List<QuestionStruct> _typeQuestionsDiversos() {
    List<QuestionStruct> listQ;
    listQ = List.generate(0, (index) => new QuestionStruct());
    for (int i = 0; i < 40; i++) {
      var rnd = Random();
      int value = rnd.nextInt(5);
      if (value == 0)
        listQ.add(new GenerateQuestionExpoentes().generateQuestionExpoentes());
      else if (value == 1)
        listQ.add(new GenerateQuestionMedia().generateQuestioMedia());
      else if (value == 2)
        listQ.add(new GenerateQuestionMMCeMDC().generateQuestionMMCeMDC());
      else if (value == 3)
        listQ.add(new GenerateQuestionNumberPrime().generateQuestionPrime());
      else
        listQ.add(
          new GenerateQuestionRegraDeTres().generateQuestionRegraDeTres(),
        );
    }
    return listQ;
  }
}
