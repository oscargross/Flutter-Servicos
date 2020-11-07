import 'package:flutter/material.dart';

class ServicoPage extends StatefulWidget {
  ServicoPage({Key key}) : super(key: key);

  @override
  _ServicoPageState createState() => _ServicoPageState();
}

class _ServicoPageState extends State<ServicoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Serviços"),
        centerTitle: true,
      ),
    );
  }
}
