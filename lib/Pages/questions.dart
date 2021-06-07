import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Pages/game.dart';
import 'package:app_math/Services/service_data_user.dart';
import 'package:flutter/material.dart';

class QuestionSelectionPage extends StatefulWidget {
  @override
  _QuestionSelectionPageState createState() => _QuestionSelectionPageState();
}

class _QuestionSelectionPageState extends State<QuestionSelectionPage> {
  ServiceDataUser serviceDataUser = new ServiceDataUser();

  var listQuestionsName = [
    "DIVERSOS",
    "MMC e MDC",
    "NÚMEROS PRIMOS",
    "CONJUNTOS",
    "MEDIA, MEDIANA e INVERVALO",
    "REGRA DE TRÊS",
    "EXPOENTES",
  ];

  @override
  Widget build(BuildContext context) {
    var widthFull = MediaQuery.of(context).size.width;
    var heightFull = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widthFull,
          height: heightFull,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppWidget.textDefault(
                text: "Selecione o Tipo de Questão: ",
                size: 20,
              ),
              listViewButtonQuestions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget listViewButtonQuestions() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 200,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listQuestionsName.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppWidget.buttonDefault(
              listQuestionsName[index],
              mWidth: 300,
              mHeight: 46,
              callback: () {
                AppWidget.screenChange(
                  context,
                  GamePage(type_game.values[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
