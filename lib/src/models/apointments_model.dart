import 'dart:io';

class Eventos {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<Evento> items = new List();

  Eventos();

  Eventos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    
    for (var item in jsonList) {
      final evento = new Evento.fromJsonMap(item);
      items.add(evento);
    }
  }
}

class Evento{
  String paciente;
  String fecha;
  String servicio;
  String descripcion;

  Evento({
    this.paciente,
    this.fecha,
    this.servicio,
    this.descripcion
  });

  Evento.fromJsonMap(Map<String, dynamic> json){
    paciente        = json['paciente'];
    fecha           = json['fecha'];
    servicio        = json['servicio'];
    descripcion     = json['descripcion'];
  }

  getPacienteEvento(){
    if (paciente == null) {
      return '';
    } else {
      return paciente;
    }
  }

  getFechaEvento(){
    if (fecha == null) {
      return '';
    } else {
      return fecha;
    }
  }

  getServicioEvento(){
    if (servicio == null) {
      return '';
    } else {
      return servicio;
    }
  }

  getDescripcionEvento(){
    if (descripcion == null) {
      return '';
    } else {
      return descripcion;
    }
  }
}