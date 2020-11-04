import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterservicos2/models/user.dart';
import 'package:flutterservicos2/services/firebase.dart';

var id;
UserCredential userCredential;
Future createUserWithEmailAndPassword(var emailVar, var passwordVar) async {
  String email = emailVar.text;
  String password = passwordVar.text;
  try {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
    print('DDDDDDDDDDDDDDDDD');
    id = await db.collection('usuario').doc(userCredential.user.uid);

    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('weak-password');
      return 'Senha muito fraca, digite uma senha mais forte';
    } else if (e.code == 'email-already-in-use') {
      print('email-already-in-use');
      return 'Este e-mail já está em uso';
    }
  } catch (e) {
    return e.toString();
  }
}

Future signInWithEmailAndPassword(var emailVar, var passwordVar) async {
  String email = emailVar.text;
  String password = passwordVar.text;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    ref = Usuario(userCredential.user.uid);
    return false;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return "E=mail não cadastrado";
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return "Senha incorreta";
    }
  }
}

Future signOut() async {
  ref = null;
  await FirebaseAuth.instance.signOut();
}
