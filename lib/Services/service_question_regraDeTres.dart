import 'dart:math';

import 'package:app_math/Struct/structs.dart';

class GenerateQuestionRegraDeTres {
  GenerateQuestionRegraDeTres();

  QuestionStruct generateQuestionRegraDeTres() {
    int v1 = 0, v2 = 0, v3 = 0;
    List<int> resultRnd = _generateRandomValues();
    v1 = resultRnd[0];
    v2 = resultRnd[1];
    v3 = resultRnd[2];

    double result = ((v2 * v3) / v1);

    Iterable<String> possibilitesResults = _generateOptions(result).map(
      (e) => e.toStringAsFixed(2),
    );

    QuestionStruct questionStruct = new QuestionStruct();
    questionStruct.question = _questions(v1, v2, v3);
    questionStruct.typeQuestion = "Regra de Tres";
    questionStruct.acceptedResult = result.toStringAsFixed(2);
    questionStruct.listResult = possibilitesResults.toList();
    return questionStruct;
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

  List<int> _generateRandomValues() {
    var rnd = Random();
    int v1 = rnd.nextInt(100);
    int v2 = rnd.nextInt(100);
    int v3 = rnd.nextInt(100);
    return [v1, v2, v3];
  }

  String _questions(int v1, int v2, int v3) {
    List<String> possibilites = [
      "Para fazer $v1 bolos de aniversário utilizamos $v3 gramas de chocolate. No entanto, faremos $v2 bolos. Qual a quantidade de chocolate que necessitaremos?",
      "Para chegar em São Paulo, Lisa demora $v1 horas numa velocidade de $v3 km/h. Assim, quanto tempo seria necessário para realizar o mesmo percurso numa velocidade de $v2 km/h?",
      "Durante um naufrágio, os sobreviventes dividiram a comida que lhes sobrou em partes iguais. Sabendo que a quantidade de comida duraria $v1 dias para os $v3 náufragos, caso fossem encontrados mais $v2 sobreviventes e a comida fosse redistribuída, a quantidade de dias aproximadamente que ela duraria seria de:",
      "Para esvaziar totalmente uma piscina com volume de $v1 L, com $v3 ralos de mesma vazão, são necessárias cerca de $v2 horas. Qual seria o tempo necessário em horas para esvaziar a piscina se ela tivesse um ralo a menos?",
      "A cada $v1 partidas Lucas ganha $v3 pontos em um determinado jogo, quantas partidas Lucas precisa jogar para chegar a $v2 pontos?"
    ];

    var rnd = Random();

    return possibilites[rnd.nextInt(possibilites.length)];
  }
}
