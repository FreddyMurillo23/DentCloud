class EventosModelo{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;

  EventosModelo({this.paciente,this.fecha,this.servicio,this.descripcion});

  factory EventosModelo.fromJson(Map<String, dynamic> json) {
    return EventosModelo(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion']
    );
  }
}