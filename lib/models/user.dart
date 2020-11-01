import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String uid;
  DocumentReference reference;

  Usuario(this.uid);

  String get userGet {
    return this.uid;
  }
}
