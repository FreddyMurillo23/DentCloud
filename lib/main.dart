import 'package:flutter/material.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/signin.dart';
import 'package:muro_dentcloud/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DentCloud_APP',
      theme: ThemeData(
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
    );
  }
}
