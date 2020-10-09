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

class EventosHoldProvider with ChangeNotifier{
  List<EventosModelo> eventosHold = List<EventosModelo>();

  void listarEventosonHold(String email){
    EventosCtrl.listarEventosPendientes(email).then((value){
      if(value!=null){
        this.eventosHold = value;
        print(value.hashCode);
      } else{
        this.eventosHold = List<EventosModelo>();
        print(value.hashCode);
        
      }
      notifyListeners();
    });
  }
}