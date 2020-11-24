import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class HiredServiceClient extends StatefulWidget {
  HiredServiceClient({Key key}) : super(key: key);

  @override
  HiredServiceClientState createState() => HiredServiceClientState();
}

class HiredServiceClientState extends State<HiredServiceClient> {
  var snapshot = db
      .collection('servicoContratado')
      .where('idCliente', isEqualTo: ref.uid)
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

                return Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: 165.0,
                      child: Row(
                        children: <Widget>[
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
                                        "Profissional: " + doc['profissional'],
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
                                        "Cidade: " + doc['cidade'],
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      const SizedBox(width: 8),
                                      FlatButton(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${doc['confirmado'] == true ? "Confirmado pelo profissional" : "Aguardando confirmação"}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: doc['confirmado'] == true
                                                    ? Colors.red
                                                    : Colors.black,
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          doc['confirmado'] == true
                                              ? showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text(
                                                        "Serviço agendado!"),
                                                    content: Text(
                                                        "Entre em contato com o profissional para mais informações"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Voltar"),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text(
                                                        "Deseja Cancelar este serviço?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Não"),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () async {
                                                          await doc.reference
                                                              .delete();

                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "Serviço excluído com sucesso!"),
                                                                    content: Text(
                                                                        "Para novas contratações, procure um profissional e agende seu serviço"),
                                                                  ));
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
    );
  }
}
