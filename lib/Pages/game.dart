import 'dart:async';

import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Services/format_question.dart';
import 'package:app_math/Services/select_question_for_type.dart';
import 'package:app_math/Services/service_data_user.dart';
import 'package:app_math/Struct/dataUser.dart';
import 'package:app_math/Struct/structs.dart';
import 'package:flutter/material.dart';

enum type_game {
  DIVERSOS,
  Q_MMC_MDC,
  Q_NUMBER_PRIME,
  Q_CONJUNTOS,
  Q_MEDIA_MEDIANA_INTERVALO,
  Q_REGRA_TRES,
  Q_EXPOENTES,
}

class GamePage extends StatefulWidget {
  final type_game _mType;

  GamePage(this._mType);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  List<QuestionStruct> listQuestions = List.empty();
  int indexQuestion = -1;
  int points = 0;
  bool finalized = false;
  QuestionStruct questionActual = new QuestionStruct();
  late AnimationController animationController;
  ServiceDataUser dataBase = new ServiceDataUser();
  UserSession userSession = new UserSession(questions: []);

  @override
  void initState() {
    super.initState();

    SelectTypeQuestions getQuestions = new SelectTypeQuestions(widget._mType);
    listQuestions = getQuestions.getListQuestions();
    userSession.questions = List.generate(0, (index) => new Question());

    // Load First Question
    Timer(Duration(seconds: 1), () {
      setState(() {
        _nextQuestion();
      });
    });

    initCounter();
  }

  initCounter() async {
    animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..addListener(() => setState(() {}));

    // AGUARDA FILNALIZAR COUNTER
    await animationController.animateBack(1);

    // AO FINALIZAR A RODADA DE DESAFIOS ATUALIZA NO BANCO DE DADOS
    // PODENDO SER LOCAL OU ONLINE
    await onTimeOut();

    // FINALIZOU COUNTER
    __showTransparentDialogOnFinalized(context);
  }

  onTimeOut() async {
    finalized = true;
    userSession.point = points;
    userSession.typeSession = widget._mType.toString();
    dataBase.mdataUser.userSessions.add(userSession);
    dataBase.mdataUser.pointsGeralUser += points;
    await dataBase.attDataUser();
  }

  _checkQuestion(String selected, QuestionStruct question) async {
    // INICIALIZA UM OBJETO DO TIPO DATA QUESTION (DADOS QUE VAO PARA O FIREBASE)
    Question mDataQuestion = new Question();
    mDataQuestion.enunQuestion = question.question;
    mDataQuestion.selectedResult = selected;
    mDataQuestion.typeQuestion = question.typeQuestion;

    setState(() {
      if (selected == question.acceptedResult) {
        mDataQuestion.correct = true;
        listQuestions[indexQuestion].finalized = true;
        _showTransparentDialogOnNext(context);
        points += 30;
      } else {
        mDataQuestion.correct = false;
        points -= 10;
      }
    });
    userSession.questions.add(mDataQuestion);
  }

  _nextQuestion() {
    indexQuestion++;
    questionActual = listQuestions[indexQuestion];
    questionActual.listResult.shuffle();
  }

  __showTransparentDialogOnFinalized<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 250,
            width: 100,
            child: FormatQuestionsResult.widgetStatusFinal(listQuestions),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Tentar Novamente!"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Quero saber mais sobre o assunto!"),
            ),
          ],
        );
      },
    );
  }

  _showTransparentDialogOnNext<T>(BuildContext context) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Image.asset("assets/images/sucess.gif"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextQuestion();
              },
              child: Text("Próximaaa :)"),
            )
          ],
        );
      },
    );
  }

  Future<bool> _willPopCallback() async {
    if (!finalized) {
      bool returnBack = await AppWidget.dialogGame(
        context: context,
        subtitle:
            "Se você sair antes de finalizar a sessão tera uma penalidade de 200 pontos! Deseja Sair?",
      );

      // SE SAIR ANTES DE ACABAR
      if (returnBack == true) {
        animationController.stop();
        dataBase.mdataUser.pointsGeralUser -= 200;
        dataBase.attDataUser();
        return true;
      } else {
        return false;
      }
    } else {
      animationController.stop();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: mWidth,
            height: mHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                head(),
                question(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget head() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: animationController.value,
                  backgroundColor: Colors.red,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                bottom: 5,
                right: 5,
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/in_progress.gif"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 30),
          Container(
            height: 100,
            width: 160,
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.lightBlue[100],
              child: Center(
                child: AppWidget.textDefault(
                  text: "Concluídas: $indexQuestion\nPontuação: $points",
                  size: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget question() {
    return Column(
      children: [
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width - 50,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppWidget.textDefault(
                text: questionActual.question,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        widgetBtnListAlternatives(questionActual),
      ],
    );
  }

  Widget widgetBtnListAlternatives(QuestionStruct questionStruct) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: questionStruct.listResult.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () => _checkQuestion(
                questionActual.listResult[index],
                questionActual,
              ),
              child: AppWidget.textDefault(
                text: questionActual.listResult[index],
                color: Colors.white,
                size: 25,
              ),
            ),
          );
        },
      ),
    );
  }
}
