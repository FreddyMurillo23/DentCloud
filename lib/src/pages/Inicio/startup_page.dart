import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaUser.dart';
import 'package:muro_dentcloud/src/pages/Inicio/home_page.dart';
import 'package:muro_dentcloud/src/pages/Inicio/post_publicaciones.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_bussiness.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_user_profile.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import '../agenda/agendaDoctor.dart';
import 'card_page.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';

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
    final _screenSize = MediaQuery.of(context).size;
    // NegocioData businessinfo = ModalRoute.of(context).settings.arguments;
    final prefs = new PreferenciasUsuario();
  

    final List<Widget> _widgetOptions = <Widget>[
      CardPage(currentuser: userinfo,),
      HomePage(currentuser: userinfo),
      PostPublicaciones(currentuser: userinfo,publicacion: new Publicacion(),),
      userinfo.tipoUsuario == 'D'
      ?Agenda3(
        currentuser: userinfo,
      )
      : AgendaUser(
        currentuser: userinfo,
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
      drawer: NavDrawer(currentuser: userinfo,),
      appBar: AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,
      // floa ting: true,
      actions: [

        CircleButton(
          icon: MdiIcons.chatOutline,
          iconsize: 30.0,
          colorIcon: Colors.blue[600],
          colorBorde: Colors.lightBlue[50],
          onPressed: () => 
         // Navigator.pushNamed(context, 'registerbusiness', arguments: userinfo)
          Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )
      ],
    ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _onItemTapped(2),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 5,
              child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Buscar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on ,color: Colors.transparent,),
              title: Text(''),
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
      ),
    );
  }
}
