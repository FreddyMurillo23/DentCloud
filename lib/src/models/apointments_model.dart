



class EventModel{ 
  String servicio;
  String fecha;
  String descripcion;
  String paciente;

  EventModel({
    this.servicio,
    this.descripcion,
    this.paciente,
    this.fecha
  });

  EventModel.fromJsonMap(Map<String, dynamic> json) {
    servicio;
    fecha;
    descripcion;
    paciente;
  }
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      paciente: json['paciente'],
      fecha: json['fecha'],
      servicio: json['servicio'],
      descripcion: json['descripcion'],     
    );
  }
}