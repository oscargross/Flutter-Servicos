import 'package:flutter/material.dart';

class PerfilUser extends StatefulWidget {
  PerfilUser({Key key}) : super(key: key);

  @override
  PerfilUserState createState() => PerfilUserState();
}

class PerfilUserState extends State<PerfilUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
      ),
    );
  }
}
