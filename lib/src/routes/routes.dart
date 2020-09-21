import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/pages/agend.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/pages/signup.dart';
import 'package:muro_dentcloud/src/pages/startup_page.dart';
import 'package:muro_dentcloud/src/widgets/add_event.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'            : (BuildContext context) => HomePage(),
    'gps'          : (BuildContext context) => ListaPage(),
    'home'         : (BuildContext context) => StartUpPage(),
    'agenda'       : (BuildContext context) => CardPage(),
    'perfil'       : (BuildContext context) => HomePage(),
    'registrarse'  : (BuildContext context) => Signup(),
    'agenda2'      : (BuildContext context) => Agenda(),
    /*'addagenda'      : (BuildContext context) => AddEventPage(),*/
  };
}
