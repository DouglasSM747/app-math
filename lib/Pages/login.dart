import 'package:app_math/Auth/service_auth.dart';
import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Pages/menu.dart';
import 'package:app_math/Services/service_data_user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inputLogin = new TextEditingController(text: "");
  TextEditingController inputPassword = new TextEditingController(text: "");
  ServiceAuth serviceAuth = new ServiceAuth();

  logIn(TypeLogin typeLogin) async {
    bool result = await serviceAuth.login(typeLogin);
    if (result == true) {
      AppWidget.screenChangeAndRemove(context, MenuPage());
    } else {
      print("Falha ao Logar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userCard(),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 60,
              child: ElevatedButton(
                onPressed: () async => await logIn(TypeLogin.GoogleLogin),
                child: buttonGoogleLogin(),
              ),
            ),
            SizedBox(height: 5),
            AppWidget.textDefault(text: "Ou ...", size: 20),
            SizedBox(height: 5),
            AppWidget.buttonDefault(
              "Continuar como visitante!",
              mWidth: MediaQuery.of(context).size.width - 100,
              callback: () async => await logIn(TypeLogin.Anonymous),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonGoogleLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/icon_google.png",
            height: 40,
          ),
        ),
        SizedBox(width: 10),
        AppWidget.textDefault(
          text: "Usar Conta Google!",
          size: 18,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget userCard() {
    return Card(
      elevation: 5,
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width - 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/defaultUser.png",
                height: 140,
              ),
            ),
            SizedBox(height: 10),
            AppWidget.textDefault(text: "Olá, Visitante :)", size: 30),
          ],
        ),
      ),
    );
  }
}
