import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/sesion/signin.dart';
import 'package:muro_dentcloud/src/providers/chat_provider.dart';
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
  //   runApp(Row(
  //   textDirection: TextDirection.ltr,
  //   crossAxisAlignment: CrossAxisAlignment.stretch,
  //   children: [
  //     /*Expanded(
  //       child: Container(color: Colors.red),
  //     ),*/
  //     Expanded(
  //       child: DevicePreview(
  //         enabled: true,
  //         plugins: [
  //           const ScreenshotPlugin(),
  //           const FileExplorerPlugin(),
  //           const SharedPreferencesExplorerPlugin(),
  //         ],
  //         // availableLocales: GalleryLocalizations.supportedLocales,
  //         builder: (context) => MyApp(),
  //       ),
  //     ),
  //   ],
  // ));
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
        ChangeNotifierProvider<ServicioProviderNuevo>(
            create: (context) => ServicioProviderNuevo()),
        ChangeNotifierProvider<DoctoresProviderName>(
            create: (context) => DoctoresProviderName()),
        ChangeNotifierProvider<EventosProvider>(
            create: (context) => EventosProvider()),
        ChangeNotifierProvider(create: (_) => new UserData()),
        ChangeNotifierProvider(create: (_) => new UserPatient()),
        ChangeNotifierProvider<EventosHoldProvider>(
            create: (context) => EventosHoldProvider()),

        ChangeNotifierProvider< ChatObtenidoProvider>(
            create: (context) => ChatObtenidoProvider()),

        ChangeNotifierProvider<  ChatlistaProvider>(
            create: (context) => ChatlistaProvider()),
 
        ChangeNotifierProvider<PDFProvider>(
            create: (context) => PDFProvider()),
        ChangeNotifierProvider<EventosUsuario>(
            create: (context) => EventosUsuario()),
        ChangeNotifierProvider<PDFProviderPatients>(
            create: (context) => PDFProviderPatients()),
        ChangeNotifierProvider<PDFProviderPatientsCita>(
            create: (context) => PDFProviderPatientsCita()),
            ChangeNotifierProvider<PDFProviderByUser>(
            create: (context) => PDFProviderByUser()),

      ],
      child: MaterialApp(
        // builder: DevicePreview.appBuilder,
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
