import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterservicos2/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });

Future createUserWithEmailAndPassword(var email, var password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

// String email;
// String imageUrl;

// Future<String> signInWithGoogle() async {
//   // ...

//   final UserCredential authResult = await _auth.signInWithCredential(credential);
//   final User user = authResult.user;

//   if (user != null) {
//     // Add the following lines after getting the user
//     // Checking if email and name is null
//     assert(user.email != null);
//     assert(user.displayName != null);
//     assert(user.photoURL != null);

//     // Store the retrieved data
//     name = user.displayName;
//     email = user.email;
//     imageUrl = user.photoURL;

//     // Only taking the first part of the name, i.e., First Name
//     if (name.contains(" ")) {
//       name = name.substring(0, name.indexOf(" "));
//     }

//     // ...

//     return '$user';
//   }

//   return null;
// }
