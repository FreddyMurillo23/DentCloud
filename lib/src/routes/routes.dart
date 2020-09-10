import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'home': (BuildContext context) => CardPage(),
    'gps': (BuildContext context) => ListaPage(),
    'agenda': (BuildContext context) => HomePage(),
    'perfil': (BuildContext context) => HomePage(),
  };
}
