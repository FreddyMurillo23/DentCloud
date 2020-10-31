import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
// import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
// import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';
// import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  final CurrentUsuario currentuser;
  const NavDrawer({Key key, this.currentuser}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool active = false;
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    // DoctoresProvider docProv = Provider.of<DoctoresProvider>(context);
    // EventosProvider eventProv = Provider.of<EventosProvider>(context);
    // EventosHoldProvider eventHoldProv = Provider.of<EventosHoldProvider>(context);
    final currentUserData = new PreferenciasUsuario();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
                child: Image(
              image: AssetImage('assets/logo.png'),
            )),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Divider(
            thickness: 1.2,
            indent: 5.5,
          ),

          Container(
            child: Column(
              children: [
                Text(
                  'Perfil Actual'.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                new CardExpansionPanel(
                  // subtitle: '',
                  headerData:
                      '${prefs.profileName}\n${prefs.profileID}', //('${widget.currentuser.openUserTrabajos.length}00'),
                  icon: Icons.supervised_user_circle,
                  iconColor: Colors.blueGrey,
                  lista: listaPerfiles(
                    widget.currentuser,
                  ),
                ),
              ],
            ),
          ),
          widget.currentuser.tipoUsuario == 'D'
          ? ListTile(
            leading: Icon(MdiIcons.pill),
            title: Text('Medicinas'),
            onTap: () => {Navigator.pushNamed(context,'medicinas')},
          )
          :Container(),

          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {Navigator.pushNamed( context,'home')},
          ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Agenda'),
          //   onTap: () => {
          //     eventHoldProv.listarEventosonHold('hvargc'),
          //     eventProv.listarEventosHold('hvarg.ec'),
          //     Navigator.of(context).pushReplacementNamed('agenda2')
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Repositorio'),
            onTap: () => {Navigator.of(context).pushNamed('agenda')},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Configuración del Perfil'),
            onTap: () => {
              // docProv.listarDoctores(),
              Navigator.pushNamed(context, 'settings',arguments: prefs.profileID),
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista Pacientes'),
            onTap: () => Navigator.pushNamed(context, 'patients'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: () {
              currentUserData.resetCurrentUserData;
              CurrentUsuarios.clearItems();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }


  Widget listaPerfiles(CurrentUsuario userinfo) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1 + widget.currentuser.openUserTrabajos.length,
        itemBuilder: (context, int index) {
          // print('${widget.currentuser.openUserTrabajos}');
          final data = widget.currentuser.openUserTrabajos;
          if (widget.currentuser.openUserTrabajos.length == 0) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                      '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                  subtitle: Text(
                      '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                  trailing: Icon(Icons.business),
                  onTap: () {
                    prefs.currentProfile = true;
                    print(userinfo.correo);
                    prefs.profileID = userinfo.correo;
                    prefs.profileName =
                        '${userinfo.nombres} ${userinfo.apellidos}';
                    print('Tap in that sheet');
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          } else if (index == 0) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                      '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                  subtitle: Text(
                      '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                  trailing: Icon(Icons.person),
                  onTap: () {
                    print(userinfo.correo);
                    prefs.currentProfile = true;
                    prefs.profileID = userinfo.correo;
                    prefs.profileName =
                        '${userinfo.nombres} ${userinfo.apellidos}';
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                    print('Im that bitch');
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          } else {
            return Column(
              children: [
                ListTile(
                  title: Text(data[index - 1].nombreNegocio),
                  subtitle: Text(
                      '${data[index - 1].idNegocio} \n${data[index - 1].rolDoctor}'),
                  trailing: Icon(Icons.business),
                  onTap: () {
                    print('Last Hore');
                    prefs.currentProfile = false;
                    prefs.profileID = data[index - 1].idNegocio;
                    prefs.profileName = data[index - 1].nombreNegocio;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          }
        });
  }
}
