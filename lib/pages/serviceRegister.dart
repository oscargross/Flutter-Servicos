import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterservicos2/services/firebase.dart';

class ServiceRegister extends StatefulWidget {
  //ServiceRegister({this.index});

  static String tag = "/serviceRegister";

  @override
  ServiceRegisterState createState() => ServiceRegisterState();
}

class ServiceRegisterState extends State<ServiceRegister> {
  var servico = TextEditingController();
  var valor =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  String erro = "";
  bool seg = true;
  bool ter = true;
  bool qua = true;
  bool qui = true;
  bool sex = true;
  bool sab = false;
  bool dom = false;

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
                    Text(
                      erro,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                    listCheck(Text('Segunda'), seg),
                    listCheck(Text('Terça'), ter),
                    listCheck(Text('Quarta'), qua),
                    listCheck(Text('Quinta'), qui),
                    listCheck(Text('Sexta'), sex),
                    listCheck(Text('Sábado'), sab),
                    listCheck(Text('Domingo'), dom),
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
                          onPressed: () async {
                            if (form.currentState.validate()) {
                              try {
                                await addService(false, false, false, false,
                                    false, false, false, valor, servico);
                              } catch (e) {
                                print(e);
                                setState(() => this.erro =
                                    "Erro ao cadastrar serviço. Tente Novamente");
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    ListServices(),
                  ]))
            ])));
  }

  Widget listCheck(Text text, bool value) {
    return CheckboxListTile(
      title: text,
      value: value,
      onChanged: (bool value) {
        setState(() {
          value = value;
        });
      },
    );
  }
}

class ListServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('servicos').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                //itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data.documents[index];
                  return ListTile(
                    //leading: Icon(Icons.panorama),
                    title: Text(doc['profissioal']),
                    // trailing: GestureDetector(
                    //   onTap: () {},
                    //   //child: Icon(Icons.delete),
                    // ),
                  );
                },
              );
            }));
  }
}
