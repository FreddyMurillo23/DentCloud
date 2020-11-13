class MensajeriaData {
  String jsontype;
  List<ChatSeleccionado> items = new List();

  MensajeriaData.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new ChatSeleccionado.fromJsonMap(item);
      items.add(publicacion);
     
    }
  }
}

class ChatSeleccionado {
  String messageId;
  String emisor;
  String receptor;
  String messageRoomId;
  String messageContent;
  DateTime messageDate;
  String messageMessageType;
  String messageUrlContent;

  ChatSeleccionado({
    this.messageId,
    this.emisor,
    this.receptor,
    this.messageRoomId,
    this.messageContent,
    this.messageDate,
    this.messageMessageType,
    this.messageUrlContent,
  });

  ChatSeleccionado.fromJsonMap(Map<String, dynamic> json) {
    messageId = json['message_id'];
    emisor = json['emisor'];
    receptor = json['receptor'];
    messageRoomId = json['message_room_id'];
    messageContent = json['message_content'];
    messageDate = DateTime.parse(json['message_date'].toString());
    messageMessageType = json['message_message_type'];
    messageUrlContent = json['message_url_content'];
    // print(fecha);
  }

  get timeHour
  {
    if( messageDate==null)
    {
      return '404';
    }
    else
    {
      var timehours;
      var timeMinute;

      if( messageDate.hour<=9)
      {
        var con= messageDate.hour;
         timehours='0$con';
      }
      else
      {
         timehours= messageDate.hour;
      }

      if( messageDate.minute<=9)
      {
        var con= messageDate.minute;
         timeMinute='0$con';
      }
      else
      {
         timeMinute= messageDate.minute;
      }
     return '$timehours:$timeMinute';

    }

  }
}