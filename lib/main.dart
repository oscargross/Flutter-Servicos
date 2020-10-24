import 'package:flutter/material.dart';
//import 'package:flutter_imed/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("title"),
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
