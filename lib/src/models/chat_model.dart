class ChatData {
  String jsontype;
  List<UltimosMensaje> items= new List();

  ChatData.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new UltimosMensaje.fromJsonMap(item);
      items.add(publicacion);
      // print(publicacion.comentarios.length);
    }
  }
 
}

class UltimosMensaje {
  String idMensaje;
  String emisor;
  String receptor;
  String sala;
  String contenidoMensaje;
 DateTime fechaHora;
  String tipoMensaje;
  String urlArchivo;
  String estadoMensaje;
  List<DatosEmisor> datosEmisor= new List();
  List<DatosReceptor> datosReceptor= new List();

  UltimosMensaje({
    this.idMensaje,
    this.emisor,
    this.receptor,
    this.sala,
    this.contenidoMensaje,
    this.fechaHora,
    this.tipoMensaje,
    this.urlArchivo,
    this.estadoMensaje,
    this.datosEmisor,
    this.datosReceptor,
  });
  UltimosMensaje.fromJsonMap(Map<String, dynamic> json){
    idMensaje=json['id_mensaje'];
    emisor=json['emisor'];
    receptor=json['receptor'];
    sala=json['sala'];
    contenidoMensaje=json['contenido_mensaje'];
    fechaHora= DateTime.parse(json['fecha_hora']);
    tipoMensaje=json['tipo_mensaje'];
    urlArchivo=json['url_archivo'];
    estadoMensaje=json['estado_mensaje'];
    if(json['datos_emisor'] != null)
    {
     for(var item in json['datos_emisor']){
        final dato= new DatosEmisor.fromJsonMap(item);
        datosEmisor.add(dato); 
     }
    }
     if(json['datos_receptor'] != null)
     {
        for(var item in json['datos_receptor']){
           final dator=new DatosReceptor.fromJsonMap(item);
           datosReceptor.add(dator);
        }
      
     }

  }

  get timeHour
  {
    if(fechaHora==null)
    {
      return '404';
    }
    else
    {
      var timehours;
      var timeMinute;

      if(fechaHora.hour<=9)
      {
        var con=fechaHora.hour;
         timehours='0$con';
      }
      else
      {
         timehours=fechaHora.hour;
      }

      if(fechaHora.minute<=9)
      {
        var con=fechaHora.minute;
         timeMinute='0$con';
      }
      else
      {
         timeMinute=fechaHora.minute;
      }
     return '$timehours:$timeMinute';

    }

  }


}

class DatosEmisor {
  String correoEmisor;
  String nombreEmisor;
  String apellidoEmisor;
  String emisorAbreviado;
  String fotoEmisor;

  DatosEmisor({
    this.correoEmisor,
    this.nombreEmisor,
    this.apellidoEmisor,
    this.emisorAbreviado,
    this.fotoEmisor,
  });

  DatosEmisor.fromJsonMap(Map<String, dynamic> json) {
    correoEmisor=json['correo_emisor'];
    nombreEmisor=json['nombre_emisor'];
    apellidoEmisor=json['apellido_emisor'];
    emisorAbreviado=json['emisor_abreviado'];
    fotoEmisor=json['foto_emisor'];
  }

}

class DatosReceptor {
  String correoReceptor;
  String nombreReceptor;
  String apellidoReceptor;
  String receptorAbreviado;
  String fotoReceptor;

  DatosReceptor({
    this.correoReceptor,
    this.nombreReceptor,
    this.apellidoReceptor,
    this.receptorAbreviado,
    this.fotoReceptor,
  });

   DatosReceptor.fromJsonMap(Map<String, dynamic> json) {
    correoReceptor=json['correo_receptor'];
    nombreReceptor=json['nombre_receptor'];
    apellidoReceptor=json['apellido_receptor'];
    receptorAbreviado=json['receptor_abreviado'];
    fotoReceptor=json['foto_receptor'];
  }


}
