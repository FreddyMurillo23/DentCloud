class EventosModelo{
  String paciente;
  String nombrePaciente;
  String apellidoPaciente;
  DateTime fechaNacimiento;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;
  String idservicio;
  String correo;
  String foto;

  EventosModelo({this.paciente,this.fecha,this.servicio,this.descripcion, this.idcita, this.correo, this.foto, this.idservicio, this.apellidoPaciente, this.fechaNacimiento, this.nombrePaciente});

  factory EventosModelo.fromJson(Map<String, dynamic> json) {
    return EventosModelo(
      paciente: json['paciente'],
      nombrePaciente: json['nombre_paciente'],
      apellidoPaciente: json['apellido_paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento_paciente'].toString()),
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

class EventosModeloHold{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;
  String idservicio;

  EventosModeloHold({this.paciente,this.fecha,this.servicio,this.descripcion,this.idcita,this.idservicio});

  factory EventosModeloHold.fromJson(Map<String, dynamic> json) {
    return EventosModeloHold(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita'],
      idservicio: json['id_servicio']
    );
  }
}