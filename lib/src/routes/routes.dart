import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/login_model.dart';
import 'package:muro_dentcloud/src/pages/agend.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/profile_page.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/pages/signup.dart';
import 'package:muro_dentcloud/src/pages/startup_page.dart';
import 'package:muro_dentcloud/src/widgets/add_event.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'            : (BuildContext context) => StartUpPage(),
    'gps'          : (BuildContext context) => ListaPage(),
    'home'         : (BuildContext context) => HomePage(),
    'agenda'       : (BuildContext context) => CardPage(),
    'perfil'       : (BuildContext context) => ProfilePage(),
    'registrarse'  : (BuildContext context) => Signup(),
    'agenda2'      : (BuildContext context) => Agenda(),
    'addagenda'      : (BuildContext context) => AddEventPage(),
  };
}
