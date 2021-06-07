import 'package:app_math/Auth/service_auth.dart';
import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Pages/game.dart';
import 'package:app_math/Pages/questions.dart';
import 'package:app_math/Services/service_data_user.dart';
import 'package:app_math/Struct/dataUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ServiceAuth serviceAuth = new ServiceAuth();
  ServiceDataUser serviceDataUser = new ServiceDataUser();
  String? userName = "";

  DataUser dataUser = new DataUser(userSessions: []);

  @override
  void initState() {
    super.initState();
    dataUser = serviceDataUser.mdataUser;

    serviceDataUser.mdataUser.userLastLogin = DateTime.now().toIso8601String();
    serviceDataUser.attDataUser();

    if (serviceAuth.signInAccount?.displayName != null) {
      userName = serviceAuth.signInAccount?.displayName;
    } else {
      userName = "Convidado";
    }
  }

  logOut() async {
    //! ANTES DE DAR LOGOUT  A LINHA ABAIXO LIMPA OS DADOS PARA NAO GERAR ERROS
    await serviceAuth.disconnect();
    if (await serviceAuth.isConnect == false) {
      setState(() {
        serviceDataUser.mdataUser = new DataUser(userSessions: []);
      });
      Phoenix.rebirth(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthFull = MediaQuery.of(context).size.width;
    var heightFull = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: AppWidget.textDefault(
          text: "Menu Principal",
          size: 30,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.login_rounded,
              size: 30,
            ),
            onPressed: () {
              logOut();
            },
          ),
        ],
      ),
      body: Container(
        width: widthFull,
        height: heightFull,
        child: Column(
          children: [
            SizedBox(height: 10),
            userInfos(),
            SizedBox(height: 10),
            AppWidget.textDefault(
              text: "Selecione o Modo de Desafio!",
              color: Colors.black,
              size: 18,
            ),
            SizedBox(height: 20),
            AppWidget.buttonDefault(
              "Testar Tudo",
              mWidth: 300,
              mHeight: 60,
              callback: () async {
                await AppWidget.screenChange(
                  context,
                  GamePage(type_game.DIVERSOS),
                );
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            AppWidget.buttonDefault(
              "Por Ano Do Ensino Fundamental",
              mWidth: 300,
              mHeight: 60,
              callback: () async {
                await AppWidget.screenChange(
                  context,
                  GamePage(type_game.DIVERSOS),
                );
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            AppWidget.buttonDefault(
              "Por Assunto",
              mHeight: 60,
              mWidth: 300,
              callback: () async {
                await AppWidget.screenChange(
                  context,
                  QuestionSelectionPage(),
                );
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget userInfos() {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 200,
      child: Card(
        child: Column(
          children: [
            AppWidget.textDefault(text: "Bem Vindo: $userName", size: 18),
            SizedBox(height: 10),
            AppWidget.avatarCircularUser(
              serviceAuth.signInAccount?.photoUrl,
              defaultImage: "https://ziu.net.br/semfoto.jpg",
              borderLevel: dataUser.levelUser,
            ),
            SizedBox(height: 10),
            AppWidget.textDefault(
              text: "Pontos: ${dataUser.pointsGeralUser}",
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
