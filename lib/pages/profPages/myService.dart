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
            if (snapshot.hasError) return const Text("");

            if (!snapshot.hasData) return const Text("Loading...");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.documents[index];
                List<String> diasSemana = [];


                if (doc['seg']) diasSemana.add("Segunda");
                if (doc['ter']) diasSemana.add("Terça");
                if (doc['qua']) diasSemana.add("Quarta");
                if (doc['qui']) diasSemana.add("Quinta");
                if (doc['sex']) diasSemana.add("Sexta");
                if (doc['sab']) diasSemana.add("Sábado");
                if (doc['dom']) diasSemana.add("Domingo");

                return Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 165.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 165.0,
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
                            height: 165,
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
                                        "${diasSemana.map((e) => e)}",
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
