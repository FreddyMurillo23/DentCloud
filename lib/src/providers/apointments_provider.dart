import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointments_ctrl.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';

class EventosProvider with ChangeNotifier{
  List<EventModel> eventos = List<EventModel>(); 

  void listarEventosPorCorreo(){
    EventosCtrl.eventosPorCorreo().then((value) {
      if(value!=null){
        this.eventos = value;
      } else{
        this.eventos = List<EventModel>();
      }
      notifyListeners();
    });
  }
}
