import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/pages/Inicio/prueba.dart';
import 'package:muro_dentcloud/src/pages/agenda/add_event.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaUser.dart';
import 'package:muro_dentcloud/src/pages/agenda/doctor_pendients.dart';
import 'package:muro_dentcloud/src/pages/agenda/receta_medica.dart';
// import 'package:muro_dentcloud/src/pages/agenda/pruebaScaffol.dart';
//import 'package:muro_dentcloud/src/pages/business_Services.dart';
import 'package:muro_dentcloud/src/pages/details_Patients.dart';
import 'package:muro_dentcloud/src/pages/Inicio/home_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/page_Services.dart';
import 'package:muro_dentcloud/src/pages/page_Settings.dart';
import 'package:muro_dentcloud/src/pages/patients_List.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_bussiness.dart';
import 'package:muro_dentcloud/src/pages/profiles/current_user_profile.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaDoctor.dart';
import 'package:muro_dentcloud/src/pages/profiles/out_business.dart';
import 'package:muro_dentcloud/src/pages/profiles/out_user.dart';
import 'package:muro_dentcloud/src/pages/sesion/await.dart';
import 'package:muro_dentcloud/src/pages/sesion/signin.dart';
import 'package:muro_dentcloud/src/pages/sesion/signup.dart';
import 'package:muro_dentcloud/src/pages/Inicio/startup_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => AwaitPage(),
    'signin': (BuildContext context) => SignIn(),
    'signup': (BuildContext context) => Signup(),
    'startuppage': (BuildContext context) => StartUpPage(),
    'gps': (BuildContext context) => ListaPage(),
    'home': (BuildContext context) => HomePage(),
    'agenda': (BuildContext context) => AddEvent(),
    'currentPerfil': (BuildContext context) => CurrentUserProfile(),
    'currentBusiness': (BuildContext context) => CurrentBusinessProfile(),
    'outPerfil': (BuildContext context) => OutUserProfile(),
    'outBusiness': (BuildContext context) => OutBusinessProfile(),
    'agenda2': (BuildContext context) => Agenda3(),
    'agendaUser': (BuildContext context) => AgendaUser(),
    'addagenda': (BuildContext context) => AddEvent(),
    'patients': (BuildContext context) => ListPatientsBuild(),
    'pruebaUser': (BuildContext context) => DetailPage(),
    'eventosPendientes': (BuildContext context) => DoctorEventsPendients(),
    'serviciosNegocios': (BuildContext context) => BusinessServicePage(),
    'settings': (BuildContext context) => SettingsPage(),
    'prueba': (BuildContext context) => Prueba(),
    'recetas': (BuildContext context) => RecetaMedica(),
    // 'postPublicacion': (BuildContext context) => PostPublicacionPage(),
  };
}
