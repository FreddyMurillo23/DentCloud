// Generated by https://quicktype.io

import 'package:muro_dentcloud/src/models/doctors_model.dart';

class AdminDocs {
  List<DoctoresDato> items = new List<DoctoresDato>();
  AdminDocs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final negocio = new DoctoresDato.fromJSON(item);
      print(negocio);
      items.add(negocio);
    }
  }
}

class DoctoresDato {
  String doctor;
  String correo;
  String cedula;
  String fechaNacimiento;
  String celular;
  String fotoPerfil;
  String profesion;
  bool status;

  DoctoresDato({
    this.doctor,
    this.correo,
    this.cedula,
    this.fechaNacimiento,
    this.celular,
    this.fotoPerfil,
    this.profesion,
    this.status,
  });

  DoctoresDato.fromJSON(Map<String, dynamic> json) {
    try {
      doctor = json["doctor"];
      correo = json["correo"];
      cedula = json["cedula"];
      celular = json["celular"];
      profesion = json["profesion"];
      fotoPerfil = json["foto_perfil"];
      fechaNacimiento = json["fecha_nacimiento"];
      status = json["status"].toString() == 'true' ? true : false;
    } catch (e) {
      print(e);
    }
  }
}
