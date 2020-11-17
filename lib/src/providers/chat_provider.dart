import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/models/chat_model.dart';
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

class ChatlistaProvider with ChangeNotifier{
  DataProvider1 lista = new DataProvider1();
   List<UltimosMensaje> listaChat = List<UltimosMensaje>();

  void listaChatObtenida(String email)
  {
     DataProvider1.getListaChat(email).then((value) {
       if(value!=null)
       {
         this.listaChat=value;
       }
       else
       {
         this.listaChat=List<UltimosMensaje>();
       }
      notifyListeners();
     });

  }

}