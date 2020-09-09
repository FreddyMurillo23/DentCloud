import 'package:flutter/material.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/startup_page.dart';
import 'package:muro_dentcloud/src/pages/home_page.dart';

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
      home: StartUpPage(),
    );
  }
}
