import 'package:app_math/Struct/structs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Rating { LOW, MEDIUM, HIGH }

class StatusResult {
  String typeQuestion = "";
  Rating rating = Rating.LOW;
  int quantAllQuestions = 0;
  int quantAcceptedsQuestions = 0;
}

class FormatQuestionsResult {
  static List<StatusResult> _questionsStatusEndGame(
      List<QuestionStruct> listQuestions) {
    var questionsStatus = {};
    List<StatusResult> listStatus =
        List.generate(0, (index) => new StatusResult());

    for (var element in listQuestions) {
      questionsStatus[element.typeQuestion] = 0;
    }

    for (var element in listQuestions) {
      if (element.finalized) questionsStatus[element.typeQuestion] += 1;
    }

    questionsStatus.forEach((key, value) {
      var statusResult = new StatusResult();
      statusResult.typeQuestion = key;
      statusResult.quantAcceptedsQuestions = value;
      statusResult.quantAllQuestions = _sumElementsInList(listQuestions, key);

      if (value == 0) {
        statusResult.rating = Rating.LOW;
      } else if (statusResult.quantAcceptedsQuestions <=
          statusResult.quantAllQuestions / 2) {
        statusResult.rating = Rating.MEDIUM;
      } else {
        statusResult.rating = Rating.HIGH;
      }
      listStatus.add(statusResult);
    });
    return listStatus;
  }

  static Widget widgetStatusFinal(List<QuestionStruct> listQuestions) {
    var listStatusResult = _questionsStatusEndGame(listQuestions);

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listStatusResult.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            width: 100,
            child: Row(
              children: [
                Text(
                  "${listStatusResult[index].typeQuestion} : ${listStatusResult[index].quantAcceptedsQuestions} / ${listStatusResult[index].quantAllQuestions} ",
                ),
                if (listStatusResult[index].rating == Rating.LOW) ...{
                  Icon(Icons.account_circle_outlined, color: Colors.red)
                } else if (listStatusResult[index].rating == Rating.MEDIUM) ...{
                  Icon(Icons.account_circle_outlined, color: Colors.yellow)
                } else ...{
                  Icon(Icons.account_circle_outlined, color: Colors.green)
                }
              ],
            ),
          );
        });
  }

  static int _sumElementsInList(
    List<QuestionStruct> listQuestion,
    String typeQuestion,
  ) {
    int count = 0;
    for (var element in listQuestion) {
      if (element.typeQuestion == typeQuestion) count++;
    }
    return count;
  }
}
