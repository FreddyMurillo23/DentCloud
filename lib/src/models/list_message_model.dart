class ListaChatData {
  String jsontype;
  List<ListaChat> items=new List();

  ListaChatData.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new ListaChat.fromJsonMap(item);
      items.add(publicacion);
      // print(publicacion.comentarios.length);
    }
  }
}

class ListaChat{
  String receptor;
  String emailReceptor;
  String sala;
  String contenido;
  DateTime fecha;
  String foto;

  ListaChat({
    this.receptor,
    this.emailReceptor,
    this.sala,
    this.contenido,
    this.fecha,
    this.foto,
  });
  ListaChat.fromJsonMap(Map<String, dynamic> json) 
  {
    receptor = json['receptor'];
    emailReceptor=json['email_receptor'];
    contenido = json['contenido'];
    fecha = DateTime.parse(json['fecha'].toString()); // convertir 
    foto=json['foto'];
    // print(fecha);
  }

  get timeHour
  {
    if(fecha==null)
    {
      return '404';

    } else {
    final timeHours=fecha.hour;
    final timeMinute=fecha.minute;
    return '$timeHours:$timeMinute';
    }

  }
}
