import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterservicos2/pages/findProfessional.dart';
import 'package:flutterservicos2/pages/pages-menu/home_page.dart';
import './pages/login.dart';
import './pages/singUp.dart';
import './pages/serviceRegister.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ServiçosApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: HexColor("#F5B732"),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/signUp': (context) => SignUp(),
          '/serviceRegister': (context) => ServiceRegister(),
          '/findProfessional': (context) => FindProfessional(),
          '/home_page': (context) => HomePage(),
        });
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
