class Doctores{
  String correo;
  String cedula;

  Doctores({this.correo,this.cedula});

  factory Doctores.fromJson(Map<String, dynamic> json) {
    return Doctores(
      correo: json['correo'],
      cedula: json['cedula']
    );
  }
}