import 'dart:math';

import 'package:app_math/Struct/structs.dart';

class GenerateQuestionMMCeMDC {
  GenerateQuestionMMCeMDC();

  QuestionStruct generateQuestionMMCeMDC() {
    int v1 = 0, v2 = 0, v3 = 0;
    List<int> resultRnd = _generateRandomValues();
    v1 = resultRnd[0];
    v2 = resultRnd[1];
    v3 = resultRnd[2];

    List<String> question = _generateQuestion(v1, v2, v3);

    double result;

    if (question[1] == "mmc") {
      result = _mmc(v1, _mmc(v2, v3).toInt());
    } else {
      result = _mdc(v1, _mmc(v2, v3).toInt()).toDouble();
    }

    Iterable<String> possibilitesResults = _generateOptions(result).map(
      (e) => e.toStringAsFixed(2),
    );

    QuestionStruct questionStruct = new QuestionStruct();
    questionStruct.question = question[0];
    questionStruct.typeQuestion = "MMC/MDC";
    questionStruct.acceptedResult = result.toStringAsFixed(2);
    questionStruct.listResult = possibilitesResults.toList();
    return questionStruct;
  }

  int _mdc(int num1, int num2) {
    int resto;
    if (num2 == 0) num2 = 4;
    do {
      resto = num1 % num2;
      num1 = num2;
      num2 = resto;
    } while (resto != 0);

    return num1;
  }

  double _mmc(int n1, int n2) {
    int resto, a, b;

    if (n2 == 0) n2 = 1;

    a = n1;
    b = n2;

    do {
      resto = a % b;

      a = b;
      b = resto;
    } while (resto != 0);

    return (n1 * n2) / a;
  }

  List<int> _generateRandomValues() {
    var rnd = Random();
    int v1 = rnd.nextInt(15);
    int v2 = rnd.nextInt(8);
    int v3 = rnd.nextInt(10);
    return [v1, v2, v3];
  }

  List<String> _generateQuestion(int v1, int v2, int v3) {
    var rnd = Random();
    List<int> pb = [0, 0, 1, 1];
    int valueRnd = pb[rnd.nextInt(pb.length)];

    if (valueRnd == 0) {
      return ["Qual é o mínimo múltiplo comum de $v1, $v2, $v3 ?", "mmc"];
    } else {
      return ["Qual é o máximo divisor comum de $v1, $v2, $v3 ?", "mdc"];
    }
  }

  List<double> _generateOptions(double result) {
    List<double> listDb = List.generate(5, (index) => 0);
    var rnd = Random();

    listDb[0] = result;

    for (int i = 1; i < 5; i++) {
      double valueAux = result;
      while (listDb.contains(valueAux)) {
        if (i % 2 == 0) {
          valueAux = result + rnd.nextInt(50);
        } else {
          valueAux = result - rnd.nextInt(50);
        }
      }
      listDb[i] = valueAux.abs();
    }
    return listDb;
  }
}
