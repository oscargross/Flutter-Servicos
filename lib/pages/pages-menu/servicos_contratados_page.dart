import 'package:flutter/material.dart';

class ServicoContratadosPage extends StatefulWidget {
  ServicoContratadosPage({Key key}) : super(key: key);

  @override
  _ServicoContratadosPageState createState() => _ServicoContratadosPageState();
}

class _ServicoContratadosPageState extends State<ServicoContratadosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Serviços Contratados"),
        centerTitle: true,
      ),
    );
  }
}
