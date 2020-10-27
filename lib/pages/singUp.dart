import 'package:flutterservicos2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/pages/serviceRegister.dart';

class SignUp extends StatefulWidget {
  static String tag = "/signUp";

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool prof = true;
  bool cliente = false;
  var nome = TextEditingController();
  var cidade = TextEditingController();
  var cpf = TextEditingController();
  var email = TextEditingController();
  var senha = TextEditingController();

//class SignUp extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();

    //final Worker worker;

    return Scaffold(
        appBar: AppBar(
          title: (Text("Cadastro ")),
          backgroundColor: Colors.yellow[700],
        ),
        body: Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: ListView(children: <Widget>[
              Form(
                  key: form,
                  child: Column(children: <Widget>[
                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: nome,
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Cidade",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: cidade,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CPF/CNPJ",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: cpf,
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
                    CheckboxListTile(
                      title: const Text('Sou Profissional'),
                      subtitle: Text('Quero oferecer meus serviços'),
                      value: this.prof,
                      onChanged: (bool value) {
                        setState(() {
                          this.prof = value;
                          cliente = false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Sou Cliente'),
                      subtitle: Text('Quero contratar serviços'),
                      value: this.cliente,
                      onChanged: (bool value) {
                        setState(() {
                          this.cliente = value;
                          prof = false;
                        });
                      },
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
                                "Cadastrar",
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
                            if (form.currentState.validate()) {
                              await FirebaseFirestore.instance
                                  .collection('usuario')
                                  .add({
                                //await Firestore.instance.collection('todo').add({
                                'nome': nome.text,
                                'cidade': cidade.text,
                                'cpf': cpf.text,
                                'email': email.text,
                                'senha': senha.text,
                                'profissional': prof,
                              });
                              prof
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceRegister()))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                            }
                          },
                        ),
                      ),
                    ),
                  ]))
            ])));
  }
}
