class EventosModelo{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;
  String idservicio;
  String correo;
  String foto;

  EventosModelo({this.paciente,this.fecha,this.servicio,this.descripcion, this.idcita, this.correo, this.foto, this.idservicio});

  factory EventosModelo.fromJson(Map<String, dynamic> json) {
    return EventosModelo(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita'],
      correo: json['correo_paciente'],
      foto: json['foto_paciente'],
      idservicio: json['id_servicio'],
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