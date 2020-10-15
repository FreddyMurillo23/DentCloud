import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/profile_page.dart';
import 'package:muro_dentcloud/src/providers/menu_providers.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'card_page.dart';
import 'listview_page.dart';

class StartUpPage extends StatefulWidget {
  StartUpPage({Key key}) : super(key: key);

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    final List<Widget> _widgetOptions = <Widget>[
      CardPage(),
      HomePage(),
      ListaPage(),
      ProfilePage(
        currentuser: userinfo,
      ),
    ];
    print(userinfo);
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('GPS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.bookOpenPageVariant,
            ),
            title: Text('Agenda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.textColor,
        mouseCursor: MouseCursor.defer,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

