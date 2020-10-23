import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaUser.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_bussiness.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_user_profile.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'agenda/agendaDoctor.dart';
import 'card_page.dart';

class StartUpPage extends StatefulWidget {
  StartUpPage({Key key}) : super(key: key);

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    
    // NegocioData businessinfo = ModalRoute.of(context).settings.arguments;
    final prefs = new PreferenciasUsuario();
  

    final List<Widget> _widgetOptions = <Widget>[
      CardPage(currentuser: userinfo,),
      HomePage(),
      userinfo.tipoUsuario == 'D'
      ?Agenda3(
        currentuser: userinfo,
      )
      : AgendaUser(
        
      ),
      prefs.currentProfile
          ? CurrentUserProfile(
              currentuser: userinfo,
            )
          : CurrentBusinessProfile(currentuser: userinfo,
              currentBusiness: prefs.profileID) 
          
    ];
    // print(userinfo);_
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
