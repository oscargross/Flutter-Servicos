import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ServiceRegister extends StatefulWidget {
  //ServiceRegister({this.index});

  static String tag = "/serviceRegister";

  @override
  ServiceRegisterState createState() => ServiceRegisterState();
}

class ServiceRegisterState extends State<ServiceRegister> {
  var servico = TextEditingController();
  final valor = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ','); //after

//class SignUp extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();

    var snapshots = FirebaseFirestore.instance
        .collection('todo')
        .where('excluido', isEqualTo: false)
        .orderBy('data')
        .snapshots();

    //final Worker worker;

    return Scaffold(
        appBar: AppBar(
          title: (Text("Cadastro de Serviços:")),
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
                        labelText: "Serviço",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: servico,
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
                        labelText: "Valor",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: valor,
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
                                "Cadastrar Serviço",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              this.servico = Text("a") as TextEditingController;
                            });
                          },
                        ),
                      ),
                    ),
                  ]))
            ])));
  }
}
