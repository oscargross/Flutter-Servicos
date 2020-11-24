import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/services/firebase.dart';

class FindProfessional extends StatefulWidget {
  @override
  FindProfessionalState createState() => FindProfessionalState();
}

class FindProfessionalState extends State<FindProfessional> {
  var idCidade;
  var idServico;
  var newCity;
  var newService;
  var snapCidade = db.collection("cidades").snapshots();
  var snapTipoServico = db.collection("tipoServico").snapshots();
  var snapServicoContratado;
  var nome;
  var email;
  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("Encontre o profissional")),
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            color: Colors.white,
            child: ListView(shrinkWrap: true, children: <Widget>[
              Form(
                  key: form,
                  child: Column(children: <Widget>[
                    Container(
                        child: StreamBuilder(
                            stream: snapCidade,
                            builder: (BuildContext context,
                                AsyncSnapshot snapCidade) {
                              if (snapCidade.hasError) return const Text("");

                              if (!snapCidade.hasData)
                                return Text("Loading...");
                              if (snapCidade.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapCidade.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapCidade.data.docs[i];
                                  currencyItems.add(
                                    DropdownMenuItem<String>(
                                      child:
                                          Text(snapshot.get('city').toString()),
                                      value: snapshot.id,
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: DropdownButton(
                                        items: currencyItems,
                                        onChanged: (value) async {
                                          String city;
                                          await db
                                              .collection('cidades')
                                              .doc(value)
                                              .snapshots()
                                              .listen((snap) async {
                                            city = await snap.get('city');
                                            setState(() {
                                              newCity = city;
                                              idCidade = value;
                                              snapServicoContratado = db
                                                  .collection("servicos")
                                                  .where('servico',
                                                      isEqualTo: newService)
                                                  .where('cidade',
                                                      isEqualTo: newCity)
                                                  .snapshots();
                                            });
                                          });
                                        },
                                        value: idCidade,
                                        isExpanded: true,
                                        hint: Text(
                                          "Escolha a cidade",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
                    Container(
                        child: StreamBuilder(
                            stream: snapTipoServico,
                            builder: (BuildContext context,
                                AsyncSnapshot snapTipoServico) {
                              if (snapTipoServico.hasError)
                                return const Text("");

                              if (!snapTipoServico.hasData)
                                return const Text("Loading...");
                              if (snapTipoServico.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapTipoServico.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snapshot =
                                      snapTipoServico.data.docs[i];
                                  currencyItems.add(
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        snapshot.get('nome').toString(),
                                      ),
                                      value: snapshot.id,
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: DropdownButton(
                                        items: currencyItems,
                                        onChanged: (value) async {
                                          String service;
                                          await db
                                              .collection('tipoServico')
                                              .doc(value)
                                              .snapshots()
                                              .listen((snap) async {
                                            service = await snap.get('nome');
                                            setState(() {
                                              newService = service;
                                              idServico = value;
                                              snapServicoContratado = db
                                                  .collection("servicos")
                                                  .where('servico',
                                                      isEqualTo: newService)
                                                  .where('cidade',
                                                      isEqualTo: newCity)
                                                  .snapshots();
                                            });
                                          });
                                        },
                                        value: idServico,
                                        isExpanded: true,
                                        hint: Text(
                                          "Escolha o serviço",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            })),
                  ]))
            ])),
        Container(
          child: StreamBuilder(
            stream: snapServicoContratado,
            builder:
                (BuildContext context, AsyncSnapshot snapServicoContratado) {
              if (snapServicoContratado.hasError) return const Text("");

              if (!snapServicoContratado.hasData) return const Text("");
              if (snapServicoContratado.connectionState ==
                  ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapServicoContratado.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc =
                      snapServicoContratado.data.documents[index];
                  List<String> diasSemana = [];

                  if (doc['seg']) diasSemana.add("Segunda");
                  if (doc['ter']) diasSemana.add("Terça");
                  if (doc['qua']) diasSemana.add("Quarta");
                  if (doc['qui']) diasSemana.add("Quinta");
                  if (doc['sex']) diasSemana.add("Sexta");
                  if (doc['sab']) diasSemana.add("Sábado");
                  if (doc['dom']) diasSemana.add("Domingo");
                  String usuario = doc['profissional'];
                  db
                      .collection('usuario')
                      .doc(usuario)
                      .snapshots()
                      .listen((snap) async {
                    String n = await snap.get('nome');
                    String e = await snap.get('email');
                    setState(() => {email = e});
                    setState(() => {nome = n});
                  });

                  return Container(
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 160.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 160.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(doc['img']))),
                            ),
                            Container(
                              height: 160,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: Container(
                                        width: 260,
                                        child: Text(
                                          "Profissional: " + nome,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: Container(
                                        width: 260,
                                        child: Text(
                                          "Valor: " + doc['valor'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: Container(
                                        width: 260,
                                        child: Text(
                                          'Dias atendidos: ${diasSemana.map((e) => e)}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        FlatButton(
                                          child: const Text(
                                              'Contratar/Informações'),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text(
                                                    "Dados do Profissional"),
                                                content: Text("Nome: " +
                                                    nome +
                                                    "\n\nE-mail: " +
                                                    email +
                                                    "\n\nDias atendidos: ${diasSemana.map((e) => e)}'\n\nValor: " +
                                                    doc['valor']),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Voltar"),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () async {
                                                      await db
                                                          .collection('usuario')
                                                          .doc(ref.uid)
                                                          .snapshots()
                                                          .listen(
                                                              (snapshot) async {
                                                        var nomeCliente =
                                                            await snapshot
                                                                .get('nome');
                                                        var idCliente =
                                                            await snapshot.id;
                                                        await db
                                                            .collection(
                                                                "usuario")
                                                            .doc(doc[
                                                                'profissional'])
                                                            .snapshots()
                                                            .listen(
                                                                (snapshot) async {
                                                          var nomeProfissional =
                                                              await snapshot
                                                                  .get('nome');
                                                          var idProfissional =
                                                              await snapshot.id;

                                                          db
                                                              .collection(
                                                                  'servicoContratado')
                                                              .add({
                                                            'servico': doc
                                                                .get('servico'),
                                                            'cliente':
                                                                nomeCliente,
                                                            'idCliente':
                                                                idCliente,
                                                            'profissional':
                                                                nomeProfissional,
                                                            'idProfissional':
                                                                idProfissional,
                                                            "confirmado": false,
                                                            'cidade': doc
                                                                .get('cidade'),
                                                            'valor': doc
                                                                .get('valor'),
                                                          });
                                                        });
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "Serviço contratado com sucesso!"),
                                                                content: Text(
                                                                    "O profissional irá entrar em contato para confirmar os detalhes do agendamento"),
                                                              ));
                                                    },
                                                    child: Text(
                                                        "Contratar serviço"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
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
              );
            },
          ),
        )
      ]),
    );
  }
}
