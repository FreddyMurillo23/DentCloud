import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
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
          final duration = new Duration(seconds: 2);
          new Timer(duration, () {
            Navigator.pushReplacementNamed(context, 'signin');
          });
        } else {
          final duration = new Duration(seconds: 2);
          new Timer(duration, () {
            final login = new DataProvider();
            login.userData(email).then((value) {
              if (value) {
                
              } else {
                print("Error");
              }
            });
            Navigator.pushReplacementNamed(context, 'startuppage');
          });
        }
      });
    });

    return Scaffold(
      body: Container(
        height: _screenSize.height * 1,
        width: _screenSize.width * 1,
        child: Column(
          children: [
            SizedBox(height: _screenSize.height*0.15,),
            Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/DentCloud.png'),
            ),
            SizedBox(height: _screenSize.height*0.05,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
