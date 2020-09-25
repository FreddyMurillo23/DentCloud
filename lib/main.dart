import 'package:flutter/material.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/routes/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

const PrimaryColor = const Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DoctoresProvider>(create: (context) => DoctoresProvider()),
        ChangeNotifierProvider<EventosProvider>(create: (context) => EventosProvider()),
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
