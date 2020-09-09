import 'package:flutter/services.dart' show rootBundle;



class _MenuProvider {
  //Lista de Opciones en la que se cargaran los datos de el Json
  List<dynamic> opciones = [];



  _MenuProvider() {
    cargarData();
  }



  cargarData() {
    //Extrae los datos del Json y los pasa la variable data como tipo FUTURE
    rootBundle.loadString('data/menu_opts.json')
      .then((data) {

        print(data);
      });


  }
  //Solo Crea la una instancia de la clase privada Menu Provider declarada mas arriba
  final menuProvider = new _MenuProvider();


}
