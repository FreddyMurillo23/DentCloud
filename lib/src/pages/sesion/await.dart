import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';

class AwaitPage extends StatelessWidget {
  const AwaitPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final currentUserData = new PreferenciasUsuario();
    currentUserData.currentCorreo.then((email) {
      currentUserData.currentPassword.then((password) {
        if (email == 'empty' && password == 'empty') {
          final duration = new Duration(seconds: 3);
          new Timer(duration, () {
            Navigator.pushNamed(context, 'signin');
          });
          
        } else {
          final duration = new Duration(seconds: 3);
          new Timer(duration, () {
            Navigator.pushNamed(context, 'startuppage');
          });
          

        }
      });
    });
    
    return Scaffold(
      body: Container(
        
        height: _screenSize.height*1,
        width: _screenSize.width*1,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('assets/loading.gif'),
        ),
      ),
    );
  }
}
