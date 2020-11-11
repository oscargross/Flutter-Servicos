import 'package:flutterservicos2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/pages/serviceRegister.dart';
import 'package:flutterservicos2/services/firebase.dart';

class SignUp extends StatefulWidget {
  static String tag = "/signUp";

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  var form = GlobalKey<FormState>();
  bool prof = true;
  bool cliente = false;
  var nome = TextEditingController();
  var cidade = TextEditingController();
  var cpf = TextEditingController();
  var email = TextEditingController();
  var senha = TextEditingController();
  String erro = "";
  var snapCity = db.collection("cidades").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (Text("Cadastro")),
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
                    Container(
                        child: StreamBuilder(
                            stream: snapCity,
                            builder:
                                (BuildContext context, AsyncSnapshot snapCity) {
                              if (!snapCity.hasData)
                                return const Text("Loading...");
                              if (snapCity.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                //print(snap.data.documents);
                                for (int i = 0;
                                    i < snapCity.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapCity.data.docs[i];
                                  //print(snapshot.get('city'));
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.get('city').toString(),
                                      ),
                                      value: "${snapshot.id}",
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: DropdownButton(
                                        items: currencyItems,
                                        onChanged: (value) {
                                          setState(() {
                                            cidade = value;
                                          });
                                        },
                                        value: cidade,
                                        isExpanded: true,
                                        hint: Text(
                                          "Escolha a cidade",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
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
                    Text(
                      erro,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                var result = await addUser(
                                    nome, cidade, cpf, email, senha, prof);
                                result == false
                                    ? Navigator.pushNamed(context, '/login')
                                    : setState(() => this.erro = result);
                              }
                            }),
                      ),
                    ),
                  ]))
            ])));
  }
}
