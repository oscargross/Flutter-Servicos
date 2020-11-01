import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterservicos2/models/user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
var ref;

Future createUserWithEmailAndPassword(var emailVar, var passwordVar) async {
  String email = emailVar.text.Trim();
  String password = passwordVar.text.Trim();
  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" + email + password);

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" + email + password);

    ref = await db.collection('usuario').doc(userCredential.user.uid);

    print("BBBBBBBBBBBBBBBBBBBBBBBBBBB" + ref.id);

    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'Senha muito fraca, digite uma senha mais forte';
    } else if (e.code == 'email-already-in-use') {
      return 'Este e-mail já está em uso';
    }
  } catch (e) {
    print(e);
    return null;
  }
}
