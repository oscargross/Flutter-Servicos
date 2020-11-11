import 'package:flutter/material.dart';
import 'package:flutterservicos2/pages/findProfessional.dart';
import 'package:flutterservicos2/pages/pages-menu/perfil_page.dart';
import 'package:flutterservicos2/pages/pages-menu/servico_page.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [ServicoPage(), FindProfessional(), PerfilPage()];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: HexColor("#F5B732"),
          selectedItemBorderColor: Colors.black,
          selectedItemBackgroundColor: HexColor("#F5B732"),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          unselectedItemIconColor: Colors.black,
          unselectedItemLabelColor: Colors.black,
        ),
        selectedIndex: _selectedIndex,
        onSelectTab: (index) {
          setState(() {
            _onItemTapped(index);
            _selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Meus Serviços',
          ),
          FFNavigationBarItem(
            iconData: Icons.restore_page /*ballot_rounded*/,
            label: 'Contratados',
          ),
          FFNavigationBarItem(
            iconData: Icons.account_circle,
            label: 'Perfil',
          ),
        ],
      ),
    );
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
