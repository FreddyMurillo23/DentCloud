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
  String nombrenegocio;

  EventosModelo({this.nombrenegocio, this.paciente,this.fecha,this.servicio,this.descripcion, this.idcita, this.correo, this.foto, this.idservicio, this.apellidoPaciente, this.fechaNacimiento, this.nombrePaciente});

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
      nombrenegocio: json['nombre_negocio'] != null ? json['nombre_negocio'] : ""
    );
  }
}

class EventosModeloUsuario{
  String doctor;
  String nombreDoctor;
  String apellidoDoctor;
  DateTime fecha;
  String servicio;
  String descripcion;
  String idcita;
  String foto;
  String idServicio;
  String nombrenegocio;

  EventosModeloUsuario({this.nombrenegocio ,this.doctor,this.fecha,this.servicio,this.descripcion,this.idcita, this.foto, this.apellidoDoctor, this.nombreDoctor, this.idServicio});

  factory EventosModeloUsuario.fromJson(Map<String, dynamic> json) {
    return EventosModeloUsuario(
      doctor: json['doctor'],
      nombreDoctor: json['nombre_doctor'],
      apellidoDoctor: json['apellido_doctor'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita'],
      foto:  json['foto_doctor'],
      idServicio: json['id_servicio'],
      nombrenegocio: json['nombre_negocio'] != null ? json['nombre_negocio'] : ""
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
  String ruc;
  String image;
  String nombreNegocio;

  EventosModeloHold({this.paciente,this.nombreNegocio,this.fecha,this.servicio,this.descripcion,this.idcita,this.idservicio,this.ruc,this.image});

  factory EventosModeloHold.fromJson(Map<String, dynamic> json) {
    return EventosModeloHold(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['nombre_servicio'],
      descripcion: json['descripcion'],
      idcita: json['id_cita'],
      idservicio: json['id_servicio'],
      ruc: json['ruc_negocio'],
      image: json['foto_paciente'],
      nombreNegocio: json['nombre_negocio'],
    );
  }
}