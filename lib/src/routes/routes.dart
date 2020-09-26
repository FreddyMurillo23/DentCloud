import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/login_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/add_event.dart';
import 'package:muro_dentcloud/src/pages/agenda/agend.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/profile_page.dart';
import 'package:muro_dentcloud/src/pages/prueba.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/pages/signup.dart';
import 'package:muro_dentcloud/src/pages/startup_page.dart';
import 'package:muro_dentcloud/src/widgets/add_event2.dart';


Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'            : (BuildContext context) => SignIn(),
    'startuppage'  : (BuildContext context) => StartUpPage(),
    'gps'          : (BuildContext context) => ListaPage(),
    'home'         : (BuildContext context) => HomePage(),

    'agenda'       : (BuildContext context) => AddEvent(),
    'perfil'       : (BuildContext context) => HomePage(),

    'agenda2'      : (BuildContext context) => Agenda2(),
    'addagenda'    : (BuildContext context) => SeachAddEvent(),
  };
}
