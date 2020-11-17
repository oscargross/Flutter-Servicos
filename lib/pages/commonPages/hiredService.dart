import 'package:flutter/material.dart';

class HiredService extends StatefulWidget {
  HiredService({Key key}) : super(key: key);

  @override
  HiredServiceState createState() => HiredServiceState();
}

class HiredServiceState extends State<HiredService> {
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
