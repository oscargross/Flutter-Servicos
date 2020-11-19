import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/models/user.dart';
import 'package:flutterservicos2/services/register.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
Usuario ref;

Future addUser(
    var nome, var cidade, var cpf, var email, var senha, bool prof) async {
  try {
    var authSign = await createUserWithEmailAndPassword(email, senha);
    if (!authSign || authSign == false) {
      await db.collection('usuario').doc(ref.uid).set({
        'nome': nome.text,
        'cidade': cidade.text,
        'cpf': cpf.text,
        'email': email.text,
        'profissional': prof,
      });

      return false;
    }
    signOut();
    return authSign;
  } catch (e) {
    signOut();
    return 'Erro ao cadastrar';
  }
}

Future getNome(String id) async {
  String nome;

  try {
    await db.collection('usuario').doc(id).snapshots().listen((snap) async {
      nome = snap.get('nome');
    });
    return nome;
  } catch (e) {
    return 'aguarde';
  }
}

Future addService(bool seg, bool ter, bool qua, bool qui, bool sex, bool sab,
    bool dom, var valor, var servico) async {
  try {
    db.collection('usuario').doc(ref.uid).snapshots().listen((snapshot) async {
      var city = snapshot.get('cidade');
      db
          .collection('tipoServico')
          .doc(servico)
          .snapshots()
          .listen((snap) async {
        var service = snap.get('nome');
        var img = snap.get('imagem');

        await db.collection('servicos').add({
          'seg': seg,
          'ter': ter,
          'qua': qua,
          'qui': qui,
          'sex': sex,
          'sab': sab,
          'dom': dom,
          'valor': valor.text,
          'servico': service,
          'cidade': city,
          'profissional': ref.uid,
          'img': img,
        });
      });
    });

    return null;
  } catch (e) {
    print(e);
    return 'Não foi possível concluir o cadastro';
  }
}
