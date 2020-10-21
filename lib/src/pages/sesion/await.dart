import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';
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
          final duration = new Duration(seconds: 1);
          new Timer(duration, () {
            
            Navigator.pushReplacementNamed(context, 'signin');
          });
        } else {
          final duration = new Duration(seconds: 1);
          new Timer(duration, () {
            final login = new DataProvider();

            login.userData(email).then((value) {
              if (value.isNotEmpty) {
                
                Navigator.pushReplacementNamed(context, 'startuppage',
                    arguments: value[0]);
              } else {
                print("Error");
              }
            });
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
            SizedBox(
              height: _screenSize.height * 0.15,
            ),
            Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/DentCloud.png'),
            ),
            SizedBox(
              height: _screenSize.height * 0.05,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
