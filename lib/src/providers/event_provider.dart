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
  List<EventosModeloHold> eventosHold = List<EventosModeloHold>();

  void listarEventosonHold(String email){
    EventosCtrl.listarEventosPendientes(email).then((value){
      if(value!=null){
        this.eventosHold = value;
      } else{
        this.eventosHold = List<EventosModeloHold>();       
      }
      notifyListeners();
    });
  }
}

class EventosUsuario with ChangeNotifier{
  List<EventosModeloUsuario> eventosUsuario = List<EventosModeloUsuario>();

  void listarEventosUser(String email){
    EventosCtrl.listarEventosUsuarios(email).then((value){
      if(value!=null){
        this.eventosUsuario = value;
      } else{
        this.eventosUsuario = List<EventosModeloUsuario>();       
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