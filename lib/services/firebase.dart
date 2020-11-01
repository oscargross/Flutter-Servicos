import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterservicos2/services/register.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

String addUser(var nome, var cidade, var cpf, var email, var senha, bool prof) {
  try {
    createUserWithEmailAndPassword(email, senha);
    db.collection('usuario').doc(ref.id).set({
      'nome': nome.text,
      'cidade': cidade.text,
      'cpf': cpf.text,
      'profissional': prof,
    });
    return null;
  } catch (e) {
    print(e);
    return 'Não foi possível concluir o cadastro';
  }
}

String addService(bool seg, bool ter, bool qua, bool qui, bool sex, bool sab,
    bool dom, var valor, var servico) {
  try {
    db.collection('servicos').add({
      //await Firestore.instance.collection('todo').add({
      'seg': seg,
      'ter': ter,
      'qua': qua,
      'qui': qui,
      'sex': sex,
      'sab': sab,
      'dom': dom,
      'valor': valor.text,
      'servico': servico.text,
      'profissional': ref.id,
    });

    return null;
  } catch (e) {
    print(e);
    return 'Não foi possível concluir o cadastro';
  }
}
