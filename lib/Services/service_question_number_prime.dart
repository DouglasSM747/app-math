import 'dart:math';

import 'package:app_math/Struct/structs.dart';
import 'package:app_math/globs.dart';

class GenerateQuestionNumberPrime {
  GenerateQuestionNumberPrime();

  QuestionStruct generateQuestionPrime() {
    int value = _generateRandomValue();

    bool isPrime = _isPrime(value);

    QuestionStruct questionStruct = new QuestionStruct();
    questionStruct.question = "$value é um número primo?";
    questionStruct.typeQuestion = "Números Primos";
    questionStruct.acceptedResult = isPrime ? "Sim" : "Não";
    questionStruct.listResult = ["Sim", "Não"];
    return questionStruct;
  }

  int _generateRandomValue() {
    var rnd = Random();
    int number = primesNumbers[rnd.nextInt(primesNumbers.length)];
    List<int> possibilites = [0, 0, 0, 0, 1, 5, 10];

    int v = number + possibilites[rnd.nextInt(possibilites.length)];
    return v;
  }

  bool _isPrime(int sum) {
    bool isPrime = true;
    for (int p = 2; p < sum; p++) {
      if (sum % p == 0) {
        isPrime = false;
        break;
      }
    }
    return isPrime;
  }
}
