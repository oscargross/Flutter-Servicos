import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterservicos2/pages/findProfessional.dart';
import './pages/login.dart';
import './pages/singUp.dart';
import './pages/serviceRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ServiçosApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: '/findProfessional',
        routes: {
          '/login': (context) => Login(),
          '/signUp': (context) => SignUp(),
          '/serviceRegister': (context) => ServiceRegister(),
          '/findProfessional': (context) => FindProfessional(),
        });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ServiçosApp"),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('usuario').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return ListView.builder(
                //itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data.documents[index];

                  return ListTile(
                    //leading: Icon(Icons.panorama),
                    title: Text(doc['nome']),
                    // trailing: GestureDetector(
                    //   onTap: () {},
                    //   //child: Icon(Icons.delete),
                    // ),
                  );
                },
              );
            }));
  }
}
