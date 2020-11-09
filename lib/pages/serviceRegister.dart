import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterservicos2/models/user.dart';
import 'package:flutterservicos2/services/firebase.dart';
import 'package:flutterservicos2/services/register.dart';

import 'login.dart';

class ServiceRegister extends StatefulWidget {
  //ServiceRegister({this.index});

  static String tag = "/serviceRegister";

  @override
  ServiceRegisterState createState() => ServiceRegisterState();
}

class ServiceRegisterState extends State<ServiceRegister> {
  var servico = TextEditingController();
  var valor = MoneyMaskedTextController();
  //MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  String erro = "";
  bool seg = true;
  bool ter = true;
  bool qua = true;
  bool qui = true;
  bool sex = true;
  bool sab = false;
  bool dom = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*if (ref.uid == null) {
      return Login();
    } else {
      return Body(context);
    }*/

    return Body(context);
  }

  Widget Body(BuildContext context) {
    var form = GlobalKey<FormState>();

    var snapshot = db
        .collection('servicos')
        .where('profissional', isEqualTo: "6ITMGwJMllt27s07Ko9I")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: (Text("Cadastro de Serviços:")),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(shrinkWrap: true, children: <Widget>[
          Form(
            key: form,
            child: Column(children: <Widget>[
              Text(
                erro,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (value) => setState(() => this.erro = ""),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Serviço",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
                controller: servico,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo não pode ser vazio';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) => setState(() => this.erro = ""),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Valor",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
                controller: valor,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo não pode ser vazio';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                title: Text('Seg'),
                value: this.seg,
                onChanged: (bool value) {
                  setState(() {
                    this.seg = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Ter'),
                value: this.ter,
                onChanged: (bool value) {
                  setState(() {
                    this.ter = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Qua'),
                value: this.qua,
                onChanged: (bool value) {
                  setState(() {
                    this.qua = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Qui'),
                value: this.qui,
                onChanged: (bool value) {
                  setState(() {
                    this.qui = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Sex'),
                value: this.sex,
                onChanged: (bool value) {
                  setState(() {
                    this.sex = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Sab'),
                value: this.sab,
                onChanged: (bool value) {
                  setState(() {
                    this.sab = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Dom'),
                value: this.dom,
                onChanged: (bool value) {
                  setState(() {
                    this.dom = value;
                  });
                },
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Cadastrar Serviço",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if (form.currentState.validate()) {
                        try {
                          await addService(seg, ter, qua, qui, sex, sab, dom,
                              valor, servico);
                        } catch (e) {
                          print(e);
                          setState(() => this.erro =
                              "Erro ao cadastrar serviço. Tente Novamente");
                        }
                        Navigator.popAndPushNamed(context, '/servico_page');
                      }
                    },
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
