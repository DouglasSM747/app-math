import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Pages/game.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
            children: [
              SizedBox(height: 40),
              AppWidget.textDefault(
                text: "Selecione o Modo de Desafio!",
                color: Colors.black,
                size: 30,
              ),
              AppWidget.buttonDefault(
                "Testar Tudo!",
                mWidth: 200,
                callback: () {
                  AppWidget.screenChange(context, GamePage(type_game.DIVERSOS));
                },
              ),
              // AppWidget.buttonDefault("Por Assunto", callback: () {}),
              // AppWidget.buttonDefault("Por Ano", callback: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
