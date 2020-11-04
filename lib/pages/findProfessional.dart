import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class FindProfessional extends StatefulWidget {
  static String tag = "/findProfessional";

  @override
  FindProfessionalState createState() => FindProfessionalState();
}

class FindProfessionalState extends State<FindProfessional> {
  var selectedCurrency;

  var form = GlobalKey<FormState>();
  var cidade = TextEditingController();
  var servico = TextEditingController();
  var snap = db.collection("cidades").snapshots();

  String erro = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (Text("Encontrar Profissional ")),
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
                    //dropDownText(),
                    TextFormField(
                      onChanged: (value) => setState(() => this.erro = ""),
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
                        setState(() => this.erro = "");
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) => setState(() => this.erro = ""),
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
                    Container(
                        child: StreamBuilder(
                            stream: snap,
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              if (!snap.hasData)
                                return const Text("Loading...");
                              else {
                                List<DropdownMenuItem> currencyItems = [];
                                print(snap.data.documents);
                                for (int i = 0;
                                    i < snap.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot = snap.data.docs[i];
                                  print(snapshot.get('city'));
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.get('city').toString(),
                                        style:
                                            TextStyle(color: Color(0xff11b719)),
                                      ),
                                      value: "${snapshot.id}",
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(width: 50.0),
                                    DropdownButton(
                                      items: currencyItems,
                                      onChanged: (currencyValue) {
                                        // final snackBar = SnackBar(
                                        //   content: Text(
                                        //     'Selected Currency value is $currencyValue',
                                        //     style: TextStyle(
                                        //         color: Color(0xff11b719)),
                                        //   ),
                                        // );
                                        // Scaffold.of(context)
                                        //     .showSnackBar(snackBar);
                                        setState(() {
                                          selectedCurrency = currencyValue;
                                        });
                                      },
                                      value: selectedCurrency,
                                      isExpanded: false,
                                      hint: Text(
                                        "Choose Currency Type",
                                        style:
                                            TextStyle(color: Color(0xff11b719)),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
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
                                  "Encontrar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onPressed: () {}),
                      ),
                    ),
                  ]))
            ])));
  }

  // ignore: missing_return
  Widget dropDownText() {
    // var dataArray = await db
    //     .collection("dbInfo")
    //     .where('cidades')
    //     .get()
    //     .then((snapshot) => snapshot.docs.forEach((doc) {
    //           doc.get('city')[1];
    //         }));
  }
}
