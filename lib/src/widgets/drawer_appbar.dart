import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DoctoresProvider doctorProv = Provider.of<DoctoresProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                    ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {Navigator.of(context).pushReplacementNamed('home')},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Agenda'),
            onTap: () => {Navigator.of(context).pushReplacementNamed('agenda2')},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Repositorio'),
            onTap: () => {Navigator.of(context).pushReplacementNamed('agenda')},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Configuración del Perfil'),
            onTap: () => {
              doctorProv.listarDoctores(),
              Navigator.of(context).pushReplacementNamed('search')
              },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: () => {
              
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)
              },
          ),
        ],
      ),
      
    );
  }
}