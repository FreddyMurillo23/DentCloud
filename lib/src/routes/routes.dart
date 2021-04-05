import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/route_argument.dart';
import 'package:muro_dentcloud/src/pages/Inicio/prueba.dart';
import 'package:muro_dentcloud/src/pages/agenda/add_event.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaUser.dart';
import 'package:muro_dentcloud/src/pages/agenda/doctor_pendients.dart';
import 'package:muro_dentcloud/src/pages/agenda/edit_event.dart';
import 'package:muro_dentcloud/src/pages/agenda/receta_medica.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_eventDoctor.dart';
import 'package:muro_dentcloud/src/pages/business/register_business1.dart';
import 'package:muro_dentcloud/src/pages/comment_page.dart';
// import 'package:muro_dentcloud/src/pages/agenda/pruebaScaffol.dart';
//import 'package:muro_dentcloud/src/pages/business_Services.dart';
import 'package:muro_dentcloud/src/pages/details_Patients.dart';
import 'package:muro_dentcloud/src/pages/Inicio/home_page.dart';
import 'package:muro_dentcloud/src/pages/list_view_build_page.dart';
import 'package:muro_dentcloud/src/pages/listview_page.dart';
import 'package:muro_dentcloud/src/pages/medicinas/drougs_detail_page.dart';
import 'package:muro_dentcloud/src/pages/medicinas/drougs_page.dart';
import 'package:muro_dentcloud/src/pages/medicinas/recipe_test.dart';
import 'package:muro_dentcloud/src/pages/page_Services.dart';
import 'package:muro_dentcloud/src/pages/personalEmpresa/register_employee.dart';
import 'package:muro_dentcloud/src/pages/repositior_documentos.dart';
import 'package:muro_dentcloud/src/pages/reposittorio_documentos_user.dart';
import 'package:muro_dentcloud/src/pages/services/doctor_services_page.dart';
import 'package:muro_dentcloud/src/pages/services/servicesDoctor.dart';
import 'package:muro_dentcloud/src/pages/services/services_page.dart';
import 'package:muro_dentcloud/src/pages/setting/page_Settings.dart';
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
    'home': (BuildContext context) => HomePage(
          currentuser: null,
        ),
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
    'serviciosDoctor': (BuildContext context) => DoctorServicePage(),
    'settings': (BuildContext context) => SettingsPage(),
    'prueba': (BuildContext context) => Prueba(),
    'recetas': (BuildContext context) => RecetaMedica(),
    'messenger': (BuildContext context) => ListPage(),
    'medicinas': (BuildContext context) => DrougsPage(),
    'medicinasdetalle': (BuildContext context) => DrougsDetailsPage(),
    'registerbusiness': (BuildContext context) => RegisterBusiness(),
    'pdfRecipes': (BuildContext context) => RecipeTest(),
    'pdfRecipes2': (BuildContext context) => RecipeTest(),
    'eventDoctor': (BuildContext context) => ViewEvent(),
    'comentario': (BuildContext context) => CommentPage(),
    'repositorio': (BuildContext context) => Repositorio(),
    'repositorioUser': (BuildContext context) => RepositorioUser(),
    'servicesPages': (BuildContext context) => ServicesPages(),
    'businessDoctorServices': (BuildContext context) => BusinessDoctorServices(
        routeArgument: ModalRoute.of(context).settings.arguments),
    'editEvent': (BuildContext context) => EditEvent(),
    'registerEmploye': (BuildContext context) => RegisterEmployee(),

    // 'postPublicacion': (BuildContext context) => PostPublicacionPage(),
  };
}
