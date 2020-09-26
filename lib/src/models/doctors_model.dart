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
