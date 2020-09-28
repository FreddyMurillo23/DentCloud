import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';

class EventosProvider with ChangeNotifier{
  List<EventosModelo> eventos = List<EventosModelo>();

  void listarEventosHold(String email){
    EventosCtrl.listarEventos(email).then((value){
      if(value!=null){
        this.eventos = value;
        print(value.hashCode);
      } else{
        this.eventos = List<EventosModelo>();
        print(value.hashCode);
        
      }
      notifyListeners();
    });
  }
}