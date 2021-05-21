import 'dart:math';

import 'package:app_math/Struct/structs.dart';

class GenerateQuestionMedia {
  GenerateQuestionMedia();

  QuestionStruct generateQuestioMedia() {
    List<int> resultRnd = _generateRandomValues();
    List<String> question = genarateOptions(resultRnd);

    double result = 0;
    if (question[1] == "media") {
      result = _media(resultRnd);
    } else if (question[1] == "mediana") {
      result = _mediana(resultRnd);
    } else if (question[1] == "invervalo") {
      result = _MaiorIntervalo(resultRnd);
    }

    QuestionStruct questionStruct = new QuestionStruct();
    questionStruct.question = question[0];
    questionStruct.acceptedResult = result.toStringAsFixed(2);
    questionStruct.typeQuestion = "Media";
    questionStruct.listResult = _generateOptions(result)
        .map(
          (e) => e.toStringAsFixed(2),
        )
        .toList();
    return questionStruct;
  }

  List<String> genarateOptions(List<int> list) {
    String values = "";

    for (int i = 0; i < list.length; i++) {
      values += " [" + list[i].toString() + "] ";
    }

    var rnd = Random();
    int index = rnd.nextInt(3);
    if (index == 2) {
      return ["Qual a media dos seguintes números?\n$values", "media"];
    } else if (index == 1) {
      return ["Qual a mediana dos seguintes números?\n$values", "mediana"];
    } else if (index == 0) {
      return ["Qual o maior intervalo entre 2 números?\n$values", "invervalo"];
    } else {
      return ["Qual a mediana dos seguintes números?\n$values", "mediana"];
    }
  }

  List<int> _generateRandomValues() {
    var rnd = Random();
    var range = 5 + rnd.nextInt(10 - 5);
    List<int> listValues = List.generate(range, (index) => 0);
    for (int i = 0; i < listValues.length; i++) {
      int value = rnd.nextInt(50);
      while (listValues.contains(value)) {
        value = rnd.nextInt(50);
      }
      listValues[i] = value;
    }
    return listValues;
  }

  List<double> _generateOptions(double result) {
    List<double> listDb = List.generate(5, (index) => 0);
    var rnd = Random();

    listDb[0] = result;

    for (int i = 1; i < 5; i++) {
      double valueAux = result;
      while (listDb.contains(valueAux)) {
        if (i % 2 == 0) {
          valueAux = result + rnd.nextInt(10);
        } else {
          valueAux = result - rnd.nextInt(10);
        }
      }
      listDb[i] = valueAux.abs();
    }
    return listDb;
  }

  double _media(List<int> list) {
    int value = 0;
    for (int i = 0; i < list.length; i++) {
      value += list[i];
    }
    return (value / list.length);
  }

  double _mediana(List<int> list) {
    list.sort();
    return list[list.length ~/ 2].toDouble();
  }

  double _MaiorIntervalo(List<int> list) {
    int min = list[0], max = -1;
    for (int i = 0; i < list.length; i++) {
      if (list[i] < min) {
        min = list[i];
      }
      if (list[i] > max) {
        max = list[i];
      }
    }
    return (max - min).toDouble();
  }
}
