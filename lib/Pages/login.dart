import 'package:app_math/Components/AppWidget.dart';
import 'package:app_math/Pages/menu.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inputLogin = new TextEditingController(text: "");
  TextEditingController inputPassword = new TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthFull = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: AppWidget.textDefault(
                text: "Bem Vindo :)",
                color: Color(0xFF333333),
                size: 36.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: AppWidget.textFormFieldDefault(
                controller: inputLogin,
                textLabel: "Usuário",
                sizeLabel: 15,
                sizeInput: 15,
                paddingHorizontal: 20.0,
                paddingVertical: 20.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: AppWidget.textFormFieldDefault(
                controller: inputPassword,
                textLabel: "Senha",
                sizeLabel: 15,
                sizeInput: 15,
                paddingHorizontal: 20.0,
                paddingVertical: 20.0,
                isObscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: AppWidget.buttonDefault(
                "Entrar",
                mWidth: 250,
                callback: () => AppWidget.screenChange(
                  context,
                  MenuPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
