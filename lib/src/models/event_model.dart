class EventosModelo{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;

  EventosModelo({this.paciente,this.fecha,this.servicio,this.descripcion, this.idcita});

  factory EventosModelo.fromJson(Map<String, dynamic> json) {
    return EventosModelo(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita']
    );
  }
}

class EventosModeloUsuario{
  String doctor;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;

  EventosModeloUsuario({this.doctor,this.fecha,this.servicio,this.descripcion,this.idcita});

  factory EventosModeloUsuario.fromJson(Map<String, dynamic> json) {
    return EventosModeloUsuario(
      doctor: json['doctor'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita']
    );
  }
}