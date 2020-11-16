import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/models/lista_chat_model.dart';

import 'data_provide1.dart';

class ChatObtenidoProvider with ChangeNotifier{
  DataProvider1 chat= new DataProvider1();
  List<ChatSeleccionado> chatSelecionado = List<ChatSeleccionado>();

  void chatActual(String sala){
    
    chat.obtenerChat(sala).then((value){
      if(value!=null){
        this.chatSelecionado = value;
      } else{
        this.chatSelecionado = List<ChatSeleccionado>();        
      }
      notifyListeners();
    });
  }
}