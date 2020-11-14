import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class FindProfessional extends StatefulWidget {
  static String tag = "/findProfessional";

  @override
  FindProfessionalState createState() => FindProfessionalState();
}
//Necessario colocar valor real da string cidade e serviço nas variaveiss para realizar a pesquisa imediata no firebase
//Idea: inserir a atualização do valor quando utiliza o setState do dropdown

class FindProfessionalState extends State<FindProfessional> {
  var cidade;
  var servico;
  var snapCity = db.collection("cidades").snapshots();
  var snapService = db.collection("tipoServico").snapshots();
  var snapServiceFirebase = db.collection("servicos").snapshots();

  //String erro = "";
  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (Text("Encontre o profissional:")),
          backgroundColor: Colors.yellow[700],
        ),
        body: Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: ListView(shrinkWrap: true, children: <Widget>[
              Form(
                  key: form,
                  child: Column(children: <Widget>[
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
                                for (int i = 0;
                                    i < snapCity.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapCity.data.docs[i];
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
                    Container(
                        child: StreamBuilder(
                            stream: snapService,
                            builder: (BuildContext context,
                                AsyncSnapshot snapService) {
                              if (!snapService.hasData)
                                return const Text("Loading...");
                              if (snapService.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapService.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapService.data.docs[i];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.get('nome').toString(),
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
                                            servico = value;
                                          });
                                        },
                                        value: servico,
                                        isExpanded: true,
                                        hint: Text(
                                          "Escolha o serviço",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('servicos')
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData)
                                return const Text("Loading...");
                              return ListView.builder(
                                //itemExtent: 80.0,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data.documents[index];

                                  return ListTile(
                                    //leading: Icon(Icons.panorama),
                                    title: Text(doc['servico']),
                                    // trailing: GestureDetector(
                                    //   onTap: () {},
                                    //   //child: Icon(Icons.delete),
                                    // ),
                                  );
                                },
                              );
                            }))
                  ]))
            ])));
  }
}

// showResults() {
//   if (cidade == "" || servico == "") {
//     return Container();
//   } else {
//     var snapshot = db
//         .collection('servicos')
//         .where('cidade', isEqualTo: cidade)
//         .where('servico', isEqualTo: servico)
//         .snapshots();

// ignore: missing_return
// Widget dropDownText() {
// var dataArray = await db
//     .collection("dbInfo")
//     .where('cidades')
//     .get()
//     .then((snapshot) => snapshot.docs.forEach((doc) {
//           doc.get('city')[1];
//         }));
// }
