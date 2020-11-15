import 'package:flutter/material.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/sesion/signin.dart';
import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/providers/pdf_provider.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/routes/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:muro_dentcloud/src/services/userData_service.dart';
import 'package:muro_dentcloud/src/services/userPatients_service.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
  initializeDateFormatting().then((_) => runApp(MyApp()));
} 

const PrimaryColor = const Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DoctoresProvider>(
            create: (context) => DoctoresProvider()),
        ChangeNotifierProvider<ServicioProvider>(
            create: (context) => ServicioProvider()),
        ChangeNotifierProvider<DoctoresProviderName>(
            create: (context) => DoctoresProviderName()),
        ChangeNotifierProvider<EventosProvider>(
            create: (context) => EventosProvider()),
        ChangeNotifierProvider(create: (_) => new UserData()),
        ChangeNotifierProvider(create: (_) => new UserPatient()),
        ChangeNotifierProvider<EventosHoldProvider>(
            create: (context) => EventosHoldProvider()),
        ChangeNotifierProvider<PDFProvider>(
            create: (context) => PDFProvider()),
        ChangeNotifierProvider<EventosUsuario>(
            create: (context) => EventosUsuario()),
        ChangeNotifierProvider<PDFProviderPatients>(
            create: (context) => PDFProviderPatients()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DentCloud_APP',
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.grey),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Palette.scaffold,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: StartUpPage(),
        initialRoute: '/',
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          print('Ruta Llamada: ${settings.name}');
          return MaterialPageRoute(builder: (BuildContext context) => SignIn());
        },
      ),
    );
  }
}
