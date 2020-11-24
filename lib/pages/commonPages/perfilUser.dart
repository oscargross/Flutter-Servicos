import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterservicos2/main.dart';
import 'package:flutterservicos2/services/firebase.dart';
import 'package:flutterservicos2/services/register.dart';

class PerfilUser extends StatefulWidget {
  PerfilUser({Key key}) : super(key: key);

  @override
  PerfilUserState createState() => PerfilUserState();
}

class PerfilUserState extends State<PerfilUser> {
  var snapshot = db.collection('usuario').doc(ref.uid).snapshots();

  int _numberSensors = 0;

  void _findSensors() {
    print(_numberSensors);
  }

  String message = "Desativado";
  static const platorm = const MethodChannel("app/sensors");

  Future _androidComunicated() async {
    try {
      final int numberSens = await platorm.invokeMethod("checkSensors");

      setState(() {
        _numberSensors = numberSens;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
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

            Map<String, dynamic> data = snapshot.data.data();

            return Container(
              padding:
                  EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
              child: Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.width * 10,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 10,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  width: 30,
                                  child: Text(""),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  width: 260,
                                  child: Text(
                                    "Suas informações",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Nome: ${data['nome']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Cpf: ${data['cpf']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "E-mail: ${data['email']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Cidade: ${data['cidade']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 30, 0, 20),
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  width: 260,
                                  child: Text(
                                    "Perfil de " +
                                        (data['profissional'] == true
                                            ? "Profissional"
                                            : "Cliente"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut();
          Navigator.popAndPushNamed(context, '/login');
        },
        child: Icon(
          Icons.exit_to_app,
          color: Colors.black,
          size: 30,
        ),
        backgroundColor: HexColor("#F5B732"),
      ),
    );
  }
}
