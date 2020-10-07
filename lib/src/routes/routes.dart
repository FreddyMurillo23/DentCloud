import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/pages/agenda/add_event.dart';
import 'package:muro_dentcloud/src/pages/agenda/doctor_pendients.dart';
import 'package:muro_dentcloud/src/pages/details_Patients.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/patients_List.dart';
import 'package:muro_dentcloud/src/pages/profile_page.dart';
import 'package:muro_dentcloud/src/pages/agenda/prueba2.dart';
import 'package:muro_dentcloud/src/pages/sesion/await.dart';
import 'package:muro_dentcloud/src/pages/sesion/signin.dart';
import 'package:muro_dentcloud/src/pages/startup_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => AwaitPage(),
    'signin': (BuildContext context) => SignIn(),
    'startuppage': (BuildContext context) => StartUpPage(),
    'gps': (BuildContext context) => ListaPage(),
    'home': (BuildContext context) => HomePage(),
    'agenda': (BuildContext context) => AddEvent(),
    'perfil': (BuildContext context) => ProfilePage(),
    'agenda2': (BuildContext context) => Agenda3(),
    'addagenda': (BuildContext context) => AddEvent(),
    'patients': (BuildContext context) => ListPatientsBuild(),
    'pruebaUser': (BuildContext context) => DetailPage(),
    'eventosPendientes'    : (BuildContext context) => DoctorEventsPendients()
  };
}
