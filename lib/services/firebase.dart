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
    if (authSign == null) {
      await db.collection('usuario').doc(ref.uid).set({
        'nome': nome.text,
        'cidade': cidade.text.toUpperCase(),
        'cpf': cpf.text,
        'profissional': prof,
      });
      ref = Usuario(id);

      return null;
    }
    signOut();
    return authSign;
  } catch (e) {
    signOut();
    return 'Erro ao cadastrar';
  }
}

Future addService(bool seg, bool ter, bool qua, bool qui, bool sex, bool sab,
    bool dom, var valor, var servico) async {
  try {
    print("Chegou aqui!");
    print(ref);
    await db.collection('servicos').add({
      //await Firestore.instance.collection('todo').add({
      'seg': seg,
      'ter': ter,
      'qua': qua,
      'qui': qui,
      'sex': sex,
      'sab': sab,
      'dom': dom,
      'valor': valor.text,
      'servico': servico.text.toUpperCase(),
      'profissional': "6ITMGwJMllt27s07Ko9I",
    });

    return null;
  } catch (e) {
    print(e);
    return 'Não foi possível concluir o cadastro';
  }
}
