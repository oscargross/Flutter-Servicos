import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/main.dart';
import 'package:flutterservicos2/services/firebase.dart';

class HiredService extends StatefulWidget {
  HiredService({Key key}) : super(key: key);

  @override
  HiredServiceState createState() => HiredServiceState();
}

class HiredServiceState extends State<HiredService> {
  var snapshot = db
      .collection('servicoContratado')
      .where('cliente', isEqualTo: ref.uid)
      .snapshots();
  var listClient = [];
  var listService = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contratados"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(children: <Widget>[
          StreamBuilder(
              stream: snapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return const Text("");
                if (!snapshot.hasData) return const Text("Loading...");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                for (var i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot docs = snapshot.data.docs[i];
                  db
                      .collection('servicos')
                      .doc(docs['servico'])
                      .get()
                      .then((DocumentSnapshot docService) {
                    if (docService.exists) {
                      db
                          .collection('usuario')
                          .doc(docs['profissional'])
                          .get()
                          .then((DocumentSnapshot docClient) {
                        if (docClient.exists) {
                          listClient.add(docClient['nome']);
                          listService.add(docService['servico']);
                          return Text("ola");
                        }
                      });
                    }
                  });
                }
                listService.add("ola");
                return Container(
                    child: Card(
                        elevation: 5,
                        child: Container(
                            height: 150.0,
                            child: Row(children: <Widget>[
                              ListView.builder(
                                  itemCount: listService.length,
                                  itemBuilder: (BuildContext ctxt, int i) {
                                    print("SSSSSSSSSSS");
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: Container(
                                        width: 260,
                                        child: Text(
                                          "Serviço: " + listService[i],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    );
                                  })
                            ]))));
              }),
        ])));
  }
}
