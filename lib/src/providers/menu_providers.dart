import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {
  //Lista de Opciones en la que se cargaran los datos de el Json
  List<dynamic> opciones = [];

  _MenuProvider() {
    // cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    //Extrae los datos del Json y los pasa la variable data como tipo FUTURE
    final resp = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(resp);
    // print(dataMap['rutas']);
    opciones = dataMap['rutas'];
    return opciones;
  }
}

//Solo Crea la una instancia de la clase privada Menu Provider declarada mas arriba
final menuProvider = new _MenuProvider();
