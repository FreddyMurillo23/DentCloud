import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/logo.png')
                    )
                    ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Perfil'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Agenda'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Repositorio'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Configuración del Perfil'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesión'),
            onTap: () => {Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)},
          ),
        ],
      ),
    );
  }
}