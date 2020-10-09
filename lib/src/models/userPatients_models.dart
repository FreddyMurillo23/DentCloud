// To parse this JSON data, do
//
//     final userPatients = userPatientsFromJson(jsonString);

import 'dart:convert';

UserPatients userPatientsFromJson(String str) =>
    UserPatients.fromJson(json.decode(str));

String userPatientsToJson(UserPatients data) => json.encode(data.toJson());

class UserPatients {
  UserPatients({
    this.jsontype,
    this.pacientes,
  });

  String jsontype;
  List<Paciente> pacientes;

  factory UserPatients.fromJson(Map<String, dynamic> json) => UserPatients(
        jsontype: json["jsontype"],
        pacientes: List<Paciente>.from(
            json["pacientes"].map((x) => Paciente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jsontype": jsontype,
        "pacientes": List<dynamic>.from(pacientes.map((x) => x.toJson())),
      };
}

class Paciente {
  Paciente({
    this.paciente,
    this.correo,
    this.fechaInscripcion,
  });

  String paciente;
  String correo;
  DateTime fechaInscripcion;

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        paciente: json["paciente"],
        correo: json["correo"],
        fechaInscripcion: DateTime.parse(json["fecha_inscripcion"]),
      );

  Map<String, dynamic> toJson() => {
        "paciente": paciente,
        "correo": correo,
        "fecha_inscripcion": fechaInscripcion.toIso8601String(),
      };
}
