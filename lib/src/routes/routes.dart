import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/pages/signup.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SignIn(),
    'home': (BuildContext context) => CardPage(),
    'gps': (BuildContext context) => ListaPage(),
    'agenda': (BuildContext context) => HomePage(),
    'perfil': (BuildContext context) => HomePage(),
    'registrarse' : (BuildContext context) => Signup(),
  };
}
