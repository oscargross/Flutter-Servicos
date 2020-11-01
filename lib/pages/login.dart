import 'package:flutter/cupertino.dart';
//import 'package:flutterservicos2/assets/images/logo.png';

import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutterservicos2/pages/singUp.dart';
import 'package:flutterservicos2/services/register.dart';

class Login extends StatefulWidget {
  static String tag = "/login";

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  var form = GlobalKey<FormState>();
  var email = TextEditingController();
  var senha = TextEditingController();

  String erro = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: ListView(children: <Widget>[
              SizedBox(
                height: 220,
                width: 220,
                //child: Image.asset("assets/logo.png"),
              ),
              Form(
                  key: form,
                  child: Column(children: <Widget>[
                    Text(
                      erro,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                      controller: email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Este campo não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: senha,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Este campo não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
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
                            child: Column(
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
                            onPressed: () async {
                              dynamic result;
                              if (form.currentState.validate()) {
                                result = await createUserWithEmailAndPassword(
                                    email, senha);
                                result != null
                                    ? setState(() => this.erro = result)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                              }
                            }),
                      ),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            }))
                  ]))
            ])));
  }
}
