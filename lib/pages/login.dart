import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 0, left: 40, right: 40),
      color: Colors.white,
      child: ListView(children: <Widget>[
        SizedBox(
          height: 220,
          width: 220,
          child: Image.asset("assets/logo.png"),
        ),
        TextFormField(
          // autofocus: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "E-mail",
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          // autofocus: true,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: SizedBox.expand(
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GoogleSignInButton(
          onPressed: () {},
          darkMode: true,
          text: "Login com Google",
        ),
        SizedBox(
          height: 5,
        ),
        FacebookSignInButton(
          onPressed: () {},
          text: "Login com Facebook",
        ),
        Container(
          height: 40,
          child: FlatButton(
            child: Text(
              "Cadastre-se",
              textAlign: TextAlign.center,
            ),
            onPressed: () {},
          ),
        ),
      ]),
    ));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
