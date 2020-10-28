import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';

class EventosProvider with ChangeNotifier{
  List<EventosModelo> eventos = List<EventosModelo>();

  void listarEventosHold(String email){
    EventosCtrl.listarEventos(email).then((value){
      if(value!=null){
        this.eventos = value;
      } else{
        this.eventos = List<EventosModelo>();
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
      } else{
        this.eventosHold = List<EventosModelo>();       
      }
      notifyListeners();
    });
  }
}

class EventosUsuario with ChangeNotifier{
  List<EventosModeloUsuario> eventosHold = List<EventosModeloUsuario>();

  void listarEventosUser(String email){
    EventosCtrl.listarEventosUsuarios(email).then((value){
      if(value!=null){
        this.eventosHold = value;
      } else{
        this.eventosHold = List<EventosModeloUsuario>();       
      }
      notifyListeners();
    });
  }
}

class EventosDoctores with ChangeNotifier{
  List<EventosModelo> eventos = List<EventosModelo>();

  void listarEventosDoctor(String email){
    EventosCtrl.listarEventos(email).then((value){
      if(value!=null){
        this.eventos = value;
      } else{
        this.eventos = List<EventosModelo>();       
      }
      notifyListeners();
    });
  }
}