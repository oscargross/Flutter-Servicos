import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class FindProfessional extends StatefulWidget {
  static String tag = "/findProfessional";

  @override
  FindProfessionalState createState() => FindProfessionalState();
}

class FindProfessionalState extends State<FindProfessional> {
  var cidade;
  var servico;

  var form = GlobalKey<FormState>();
  var snapCity = db.collection("cidades").snapshots();
  var snapService = db.collection("listaServicos").snapshots();

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
                    // TextFormField(
                    //   onChanged: (value) => setState(() => this.erro = ""),
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //     labelText: "Cidade",
                    //     labelStyle: TextStyle(
                    //       color: Colors.black38,
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 20),
                    //   controller: cidade,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Este campo não pode ser vazio';
                    //     }
                    //     setState(() => this.erro = "");
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // TextFormField(
                    //   onChanged: (value) => setState(() => this.erro = ""),
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //     labelText: "Serviço",
                    //     labelStyle: TextStyle(
                    //       color: Colors.black38,
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    //   style: TextStyle(fontSize: 20),
                    //   controller: servico,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Este campo não pode ser vazio';
                    //     }
                    //     return null;
                    //   },
                    // ),
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
                              else {
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
                                      onChanged: (value) {
                                        setState(() {
                                          cidade = value;
                                        });
                                      },
                                      value: cidade,
                                      isExpanded: false,
                                      hint: Text(
                                        "Escolha a cidade",
                                        style:
                                            TextStyle(color: Color(0xff11b719)),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: StreamBuilder(
                            stream: snapService,
                            builder: (BuildContext context,
                                AsyncSnapshot snapService) {
                              if (!snapService.hasData)
                                return const Text("Loading...");
                              else {
                                List<DropdownMenuItem> currencyItems = [];
                                //print(snap.data.documents);
                                for (int i = 0;
                                    i < snapService.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapService.data.docs[i];
                                  //print(snapshot.get('city'));
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.get('service').toString(),
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
                                      onChanged: (value) {
                                        setState(() {
                                          servico = value;
                                        });
                                      },
                                      value: servico,
                                      isExpanded: false,
                                      hint: Text(
                                        "Escolha o serviço",
                                        style:
                                            TextStyle(color: Color(0xff11b719)),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                              var a = db
                                  .collection('services')
                                  .where('servico', isEqualTo: servico)
                                  .where('cidade', isEqualTo: cidade)
                                  .snapshots();
                            }),
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
