import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class FindProfessional extends StatefulWidget {
  static String tag = "/findProfessional";

  @override
  FindProfessionalState createState() => FindProfessionalState();
}

class FindProfessionalState extends State<FindProfessional> {
  var snapCity = db.collection("cidades").snapshots();
  var snapService = db.collection("tipoServico").snapshots();
  String erro = "";
  var form = GlobalKey<FormState>();
  var cidade;

  var servico;

  var teste = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (Text("Encontrar Profissional ")),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: ListView(children: <Widget>[
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
                            "Filtrar por cidade e serviço",
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
                        //modalCreate(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Filtrar'),
                                  content: Form(
                                      key: form,
                                      child: Column(children: <Widget>[
                                        Text(
                                          erro,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            child: StreamBuilder(
                                                stream: snapCity,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapCity) {
                                                  if (!snapCity.hasData)
                                                    return const Text(
                                                        "Loading...");
                                                  if (snapCity
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else {
                                                    List<DropdownMenuItem>
                                                        currencyItems = [];
                                                    //print(snap.data.documents);
                                                    for (int i = 0;
                                                        i <
                                                            snapCity.data.docs
                                                                .length;
                                                        i++) {
                                                      DocumentSnapshot
                                                          snapshot =
                                                          snapCity.data.docs[i];
                                                      //print(snapshot.get('city'));
                                                      currencyItems.add(
                                                        DropdownMenuItem(
                                                          child: Text(
                                                            snapshot
                                                                .get('city')
                                                                .toString(),
                                                          ),
                                                          value:
                                                              "${snapshot.id}",
                                                        ),
                                                      );
                                                    }
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: DropdownButton(
                                                            items:
                                                                currencyItems,
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
                                                    return const Text(
                                                        "Loading...");
                                                  if (snapService
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else {
                                                    List<DropdownMenuItem>
                                                        currencyItems = [];
                                                    for (int i = 0;
                                                        i <
                                                            snapService.data
                                                                .docs.length;
                                                        i++) {
                                                      DocumentSnapshot
                                                          snapshot = snapService
                                                              .data.docs[i];
                                                      currencyItems.add(
                                                        DropdownMenuItem(
                                                          child: Text(
                                                            snapshot
                                                                .get('nome')
                                                                .toString(),
                                                          ),
                                                          value:
                                                              "${snapshot.id}",
                                                        ),
                                                      );
                                                    }
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: DropdownButton(
                                                            items:
                                                                currencyItems,
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
                                      ])));
                            });
                      }),
                ),
              ),
              //showResults(),
            ])));
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
  //     return Container(
  //       child: StreamBuilder(
  //         stream: snapshot,
  //         builder: (BuildContext context, AsyncSnapshot snapshot) {
  //           if (!snapshot.hasData) return const Text("Loading...");
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           if (snapshot.hasError) {
  //             return Center(child: Text('Error: Nenhum dado encontrado'));
  //           }
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data.documents.length,
  //             itemBuilder: (context, index) {
  //               DocumentSnapshot doc = snapshot.data.documents[index];
  //               String servico = doc['servico'];
  //               String imagem =
  //                   "https://exitoina.uol.com.br/media/_versions/mia_khalifa_1807_widexl.jpg";
  //               return Container(
  //                 child: Card(
  //                   elevation: 5,
  //                   child: Container(
  //                     height: 150.0,
  //                     child: Row(
  //                       children: <Widget>[
  //                         Container(
  //                           height: 150.0,
  //                           width: 100.0,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.only(
  //                                   bottomLeft: Radius.circular(5),
  //                                   topLeft: Radius.circular(5)),
  //                               image: DecorationImage(
  //                                   fit: BoxFit.cover,
  //                                   image: NetworkImage(imagem))),
  //                         ),
  //                         Container(
  //                           height: 150,
  //                           child: Padding(
  //                             padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 Padding(
  //                                   padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
  //                                   child: Container(
  //                                     width: 30,
  //                                     child: Text(""),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
  //                                   child: Container(
  //                                     width: 260,
  //                                     child: Text(
  //                                       "Serviço: " + servico,
  //                                       style: TextStyle(
  //                                           fontSize: 15,
  //                                           color: Color.fromARGB(
  //                                               255, 48, 48, 54)),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
  //                                   child: Container(
  //                                     width: 260,
  //                                     child: Text(
  //                                       "Valor: " + doc['valor'],
  //                                       style: TextStyle(
  //                                           fontSize: 15,
  //                                           color: Color.fromARGB(
  //                                               255, 48, 48, 54)),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
  //                                   child: Container(
  //                                     width: 260,
  //                                     child: Text(
  //                                       "Dias: Seg, Ter, Qua, Qui, Sex",
  //                                       style: TextStyle(
  //                                           fontSize: 15,
  //                                           color: Color.fromARGB(
  //                                               255, 48, 48, 54)),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ),
  //     );
  //   }
  // }

  modalCreate(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Criar nova tarefa'),
            content: Form(
                key: form,
                child: Column(children: <Widget>[
                  Text(
                    erro,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                              return Center(child: CircularProgressIndicator());
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
                                          print("OOOOLLLLLLLAAAAAAAAAAAAAA");
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
                              return Center(child: CircularProgressIndicator());
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
                ])),
          );
        });
  }
}

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
