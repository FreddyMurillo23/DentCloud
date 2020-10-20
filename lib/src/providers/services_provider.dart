import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/controllers/servicios_ctrl.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';

class ServicioProvider with ChangeNotifier{
  List<Servicios> servicios = List<Servicios>();

  void listarServicios(String dni){
    ServiciosCtrl.listarServicios(dni).then((value){
      if(value!=null){
        this.servicios = value;
        print(value.hashCode);
      } else{
        this.servicios = List<Servicios>();
        print(value.hashCode);
        
      }
      notifyListeners();
    });
  }

  void disposeServicios(){
    this.servicios = [];
  }
}