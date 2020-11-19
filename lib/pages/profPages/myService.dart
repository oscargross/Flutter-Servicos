import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/main.dart';
import 'package:flutterservicos2/services/firebase.dart';

class MyService extends StatefulWidget {
  MyService({Key key}) : super(key: key);

  @override
  MyServiceState createState() => MyServiceState();
}

class MyServiceState extends State<MyService> {
  var snapshot = db
      .collection('servicos')
      .where('profissional', isEqualTo: ref.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Serviços"),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder(
          stream: snapshot,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.documents[index];
                // var a = db
                //     .collection('tipoServico')
                //     .where('nome', isEqualTo: doc['servico'])
                //     .snapshots();

                // a.listen((snap) async {
                //   for (var i = 0; i < snap.docs.data.length; i++) {
                //     print(snap.docs[i].data());

                //     if (snap.docs[i].get('nome') == servico) {
                //       String imagem = await snap.docs[i].get('imagem');
                //       print(imagem);
                //       setState(() => {img = imagem});
                //     }
                //   }
                // });
                return Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 150.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(doc['img']))),
                          ),
                          Container(
                            height: 150,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child: Container(
                                      width: 30,
                                      child: Text(""),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 260,
                                      child: Text(
                                        "Serviço: " + doc['servico'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 48, 48, 54)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 260,
                                      child: Text(
                                        "Valor: " + doc['valor'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 48, 48, 54)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 260,
                                      child: Text(
                                        "Dias: Seg, Ter, Qua, Qui, Sex",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 48, 48, 54)),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('EDITAR'),
                                        onPressed: () {/* ... */},
                                      ),
                                      const SizedBox(width: 8),
                                      FlatButton(
                                        child: const Text('EXCLUIR'),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text("Excluir Serviço"),
                                              content:
                                                  Text("Certeza dessa ação?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Não"),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    print("SERVIÇO EXCLUÍDO");
                                                    doc.reference.delete();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Sim"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/serviceRegister');
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 40,
        ),
        backgroundColor: HexColor("#F5B732"),
      ),
    );
  }
}
