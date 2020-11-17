class Doctores{
  String doctor;
  String correo;
  String cedula;
  DateTime fechanacimiento;
  String celular;
  String foto;

  Doctores({this.correo,this.cedula,this.celular,this.doctor,this.fechanacimiento,this.foto});

  factory Doctores.fromJson(Map<String, dynamic> json) {
    return Doctores(
      doctor:           json['doctor'],
      correo:           json['correo'],
      cedula:           json['cedula'],
      fechanacimiento:  DateTime.parse(json['fecha_nacimiento'].toString()),
      celular:          json['celular'],
      foto:             json['foto_perfil'],
    );
  }
}

class DoctoresNegocio{
  String correodoctor;
  String ceduladoctor;
  String nombredoctor;
  String roldoctor;
  String profesiondoctor;
  String celulardoctor;
  String sexodoctor;
  String fotoperfil;

  DoctoresNegocio({
    this.ceduladoctor = '',
    this.celulardoctor = '',
    this.correodoctor = '',
    this.fotoperfil = '',
    this.nombredoctor = '',
    this.profesiondoctor = '',
    this.roldoctor = '',
    this.sexodoctor = '',
  });

  factory DoctoresNegocio.fromJson(Map<String, dynamic> json) {
    return DoctoresNegocio(
      correodoctor:           json['correo_doctor'],
      ceduladoctor:           json['cedula_doctor'],
      celulardoctor:          json['celular_doctor'],
      nombredoctor:           json['nombre_doctor'],
      fotoperfil:             json['foto_perfil'],
      profesiondoctor:        json['profesion_doctor'],
      roldoctor:              json['rol_doctor'],
      sexodoctor:             json['sexo_doctor'],
    );
  }
}
