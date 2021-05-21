import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class AppWidget extends StatelessWidget {
  static double sizeScreenWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void dialog(
      {required BuildContext context,
      String title = "Alerta",
      String subtitle = "Mensagem",
      VoidCallback? voidCallback,
      ElevatedButton? newOption}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(subtitle),
          actions: <Widget>[
            if (newOption != null) ...{newOption},
            new ElevatedButton(
              child: new Text("Fechar"),
              onPressed: () {
                if (voidCallback == null) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  voidCallback();
                }
              },
            ),
          ],
        );
      },
    );
  }

  //* Função responsavel por fazer a mudança de telas, recebe como parâmetro um Widget(Deve ser uma screen, caso não, resulta em erro)
  static screenChange(BuildContext context, Widget screen) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static Route animationScreen(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Widget textFormFieldDefault({
    required TextEditingController controller,
    String textLabel = "",
    double sizeLabel = 12,
    int sizeInput = 12,
    double paddingVertical = 0,
    double paddingHorizontal = 0,
    TextInputType keyboardType = TextInputType.number,
    bool isObscureText = false,
    String hintText = "",
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      maxLength: sizeInput,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: textLabel,
        counterText: '',
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
        labelStyle: GoogleFonts.quicksand(
            textStyle: TextStyle(
          color: Colors.black,
          fontSize: sizeLabel,
        )),
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(0xFFEEB220),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  static Widget buttonInkCostumer({
    Color color = Colors.blue,
    IconData icon = Icons.add,
    double sizeIcon = 30,
    double paddingButton = 0,
    VoidCallback? voidCallback,
  }) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(6)),
          shape: BoxShape.rectangle,
          color: color,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          //Something large to ensure a circle
          onTap: voidCallback,
          child: Padding(
            padding: EdgeInsets.all(paddingButton == null ? 2 : paddingButton),
            child: Icon(
              icon,
              color: Colors.white,
              size: sizeIcon,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buttonInkCostumerCircle(
      {Color colorBorder = Colors.blue,
      Color colorIcon = Colors.blue,
      IconData icon = Icons.add,
      double sizeIcon = 30,
      VoidCallback? voidCallback}) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: voidCallback,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Icon(
              icon,
              color: colorIcon,
              size: sizeIcon,
            ),
          ),
        ),
      ),
    );
  }

  static Widget textDefault({
    String text = "",
    Color color = Colors.black,
    double size = 30,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.quicksand(
          textStyle: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      )),
    );
  }

  static Widget iconButtonDefault(
    Icon icon,
    double size,
    Color color, {
    required VoidCallback callback,
  }) {
    return IconButton(
      icon: icon,
      iconSize: size,
      color: color,
      onPressed: callback,
    );
  }

  static Widget buttonDefault(
    String text, {
    required VoidCallback callback,
    double mWidth = 120,
    double mHeight = 50,
  }) {
    return Container(
      width: mWidth,
      height: mHeight,
      child: ElevatedButton(
        onPressed: callback,
        child: textDefault(text: text, color: Colors.white, size: 25),
      ),
    );
  }

  static Widget inputTextSimple({
    required Widget textWidget,
    required TextEditingController editingController,
    String label = "",
    double height = 30,
    double width = 30,
    required Function onChanged,
    int sizeMaxInput = 18,
    TextInputType keyboardType = TextInputType.number,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget,
        Container(
          // color: Colors.red,
          width: width,
          height: height,
          child: TextFormField(
            textAlign: TextAlign.center,
            maxLines: 1,
            maxLength: sizeMaxInput,
            keyboardType: keyboardType,
            controller: editingController,
            onChanged: (_) => onChanged(),
            style: GoogleFonts.quicksand(
                textStyle: TextStyle(
              color: Color(0xFF333333),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
            decoration: InputDecoration(
              hintText: label,
              contentPadding: EdgeInsets.all(0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintStyle: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                color: Color(0xFFC0C0C0),
                fontSize: 14,
              )),
              counterText: '',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
