

class Eventos {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<EventModel> items = new List();

  Eventos();

  Eventos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    
    for (var item in jsonList) {
      final evento = new EventModel.fromJsonMap(item);
      items.add(evento);
    }
  }
}

class EventModel{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;

  EventModel({
    this.paciente,
    this.fecha,
    this.servicio,
    this.descripcion
  });

  EventModel.fromJsonMap(Map<String, dynamic> json){
    paciente        = json['paciente'];
    fecha           = DateTime.parse(json['fecha'].toString());
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
      return '0000-00-00 00-00-00';
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