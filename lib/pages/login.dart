import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/register.dart';
import 'package:flutterservicos2/services/firebase.dart';

class Login extends StatefulWidget {
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
                      onChanged: (value) => setState(() => this.erro = ""),
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
                        setState(() => this.erro = "");
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() => this.erro = ""),
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
                      obscureText: true,
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
                                result = await signInWithEmailAndPassword(
                                    email, senha);
                                await result != false
                                    ? setState(() => this.erro = result)
                                    : await db
                                        .collection('usuario')
                                        .doc(ref.uid)
                                        .snapshots()
                                        .listen((snapshot) async {
                                        await snapshot.get('profissional')
                                            ? Navigator.popAndPushNamed(
                                                context, '/serviceRegister')
                                            : Navigator.popAndPushNamed(
                                                context, '/serviceRegister');
                                      });
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 40,
                        child: FlatButton(
                            child: Text(
                              "Cadastre-se",
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signUp');
                            }))
                  ]))
            ])));
  }
}
