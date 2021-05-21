import 'dart:math';

import 'package:app_math/Struct/structs.dart';
import 'package:app_math/globs.dart';

class GenerateQuestionExpoentes {
  GenerateQuestionExpoentes();

  QuestionStruct generateQuestionExpoentes() {
    int v1, v2, v3, v4;
    List<int> resultRnd = _generateRandomValues();
    v1 = resultRnd[0];
    v2 = resultRnd[1];
    v3 = resultRnd[2];
    v4 = resultRnd[3];

    int result = (pow(v1 + v2, v4)).toInt();

    QuestionStruct questionStruct = new QuestionStruct();
    String superScriptNumber = String.fromCharCode(superscript[v4.toString()]);
    questionStruct.question = "Quanto é ($v1 + $v2) $superScriptNumber";
    questionStruct.acceptedResult = result.toString();
    questionStruct.typeQuestion = "Expoentes";
    questionStruct.listResult = _generateOptions(result)
        .map(
          (e) => e.toString(),
        )
        .toList();
    return questionStruct;
  }

  List<int> _generateRandomValues() {
    var rnd = Random();
    int v1, v2, v3, v4;
    v1 = rnd.nextInt(9);
    v2 = rnd.nextInt(4);
    v3 = rnd.nextInt(9);
    v4 = rnd.nextInt(4);
    return [v1, v2, v3, v4];
  }

  List<int> _generateOptions(int result) {
    List<int> listDb = List.generate(5, (index) => 0);
    var rnd = Random();

    listDb[0] = result;

    for (int i = 1; i < 5; i++) {
      int valueAux = result;
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
