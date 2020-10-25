import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final HttpService httpService = HttpService();
  bool isSwitched = false;
  bool freddoBobo = false;
  PreferenciasUsuario prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final String ruc = ModalRoute.of(context).settings.arguments;
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Image(
          image: AssetImage('assets/title.png'),
          height: screenSize.height * 0.1,
          fit: BoxFit.fill,
        ),
        centerTitle: false,
        // floa ting: true,
        actions: [
          CircleButton(
            icon: Icons.search,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
          CircleButton(
            icon: MdiIcons.facebookMessenger,
            iconsize: 30.0,
            onPressed: () => print('Messenger'),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: httpService.getBusinessServices(ruc),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _settingsList(snapshot.data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _settingsList(List<NegocioDato> data) {
    return Container(
      padding: new EdgeInsets.all(25.0),
      child: Column(
        children: [
          Container(
            child: Stack(
              alignment: Alignment(0.90, 0.99),
              children: [
                CircleAvatar(
                  radius: 75.0,
                  backgroundImage: NetworkImage(data[0].foto),
                ),
                GestureDetector(
                  onTap: () {
                    print(data[0].negocio +
                        "-" +
                        data[0].provincia +
                        "-" +
                        data[0].canton);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Icon(Icons.edit)),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 25.0)),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              children: [
                // prefs.thisProfileType
                _listConfiguration(
                    'Administrar Servicios', 'serviciosNegocios',prefs.profileID),
                Divider(),
                _listConfiguration('Administrar Medicamentos', 'config',prefs.profileID),
                Divider(),
                _listConfiguration('Administrar Horarios Citas', 'config',prefs.profileID),
                Divider(),
                _listConfigurationSwith('Priorizar notificaciones'),
                Divider(),
                _listConfigurationSwith('Mostrar clientes'),
                Divider(),
                _listConfigurationSwith('Mostrar precios')

                //if (freddoBobo) ...{}
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listConfiguration(String title, String pageTo, String datita) {
    return ListTile(
      title: Text(title),
      trailing: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, pageTo, arguments: datita);
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget _listConfigurationSwith(String title) {
    return ListTile(
      title: Text(title),
      trailing: FlatButton(
        onPressed: () {},
        child: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print(isSwitched);
            });
          },
          activeTrackColor: Colors.lightBlue[200],
          activeColor: Colors.blue,
        ),
      ),
    );
  }
}
