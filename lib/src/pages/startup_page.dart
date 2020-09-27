import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
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
  static List<Widget> _widgetOptions = <Widget>[
    CardPage(),
    HomePage(),
    ListaPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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




Widget _bottonNavigator() {
  return FutureBuilder(
    future: menuProvider.cargarData(),
    initialData: [],
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      print('builder');
      print(snapshot.data);

      return ListView(
        children: _items(snapshot.data, context),
      );
    },
  );

}




List<Widget> _items(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];

  data?.forEach((opt) {
    final widgetTemp = ListTile(
      title: Text(opt['texto']),
      leading: getIcon(opt['icon']),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.blue,
      ),
      onTap: () {
        Navigator.pushNamed(context, opt['ruta']);
      },
    );
    opciones..add(widgetTemp)..add(Divider());
  });
  return opciones;
}
