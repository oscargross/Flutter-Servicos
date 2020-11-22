import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class PerfilUser extends StatefulWidget {
  PerfilUser({Key key}) : super(key: key);

  @override
  PerfilUserState createState() => PerfilUserState();
}

class PerfilUserState extends State<PerfilUser> {
  var snapshot = db.collection('usuario').doc(ref.uid).snapshots();

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
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data.docs[index];

                return Container(
                  child: Card(
                      elevation: 5,
                      child: Container(
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
                                    "Nome: " + doc['nome'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
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
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Cpf: " + doc['cpf'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              });
        },
      )),
    );
  }
}
