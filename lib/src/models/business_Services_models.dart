// To parse this JSON data, do
//
//     final servicesBusiness = servicesBusinessFromJson(jsonString);

import 'dart:convert';

ServicesBusiness servicesBusinessFromJson(String str) =>
    ServicesBusiness.fromJson(json.decode(str));

String servicesBusinessToJson(ServicesBusiness data) =>
    json.encode(data.toJson());

class ServicesBusiness {
  ServicesBusiness({
    this.jsontype,
    this.negocioDatos,
  });

  String jsontype;
  List<NegocioDato> negocioDatos;

  factory ServicesBusiness.fromJson(Map<String, dynamic> json) =>
      ServicesBusiness(
        jsontype: json["jsontype"],
        negocioDatos: List<NegocioDato>.from(
            json["negocio_datos"].map((x) => NegocioDato.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jsontype": jsontype,
        "negocio_datos":
            List<dynamic>.from(negocioDatos.map((x) => x.toJson())),
      };
}

class NegocioDato {
  NegocioDato({
    this.inicialNegocio,
    this.ruc,
    this.negocio,
    this.telefono,
    this.provincia,
    this.canton,
    this.ubicacion,
    this.foto,
    this.servicios,
    this.personal,
    this.publicacionesNegocio,
  });

  InicialNegocio inicialNegocio;
  String inicialNegocio;
  String ruc;
  Negocio negocio;
  String negocio;
  String telefono;
  String provincia;
  String canton;
  String ubicacion;
  String foto;
  List<Servicio> servicios;
  List<Personal> personal;
  List<PublicacionesNegocio> publicacionesNegocio;

  factory NegocioDato.fromJson(Map<String, dynamic> json) => NegocioDato(
        inicialNegocio: inicialNegocioValues.map[json["inicial_negocio"]],
        inicialNegocio: json["inicial_negocio"],
        ruc: json["ruc"],
        negocio: negocioValues.map[json["negocio"]],
        telefono: json["telefono"],
        provincia: json["provincia"],
        canton: json["canton"],
        ubicacion: json["ubicacion"],
        foto: json["foto"],
        servicios: List<Servicio>.from(
            json["servicios"].map((x) => Servicio.fromJson(x))),
        personal: List<Personal>.from(
            json["personal"].map((x) => Personal.fromJson(x))),
        publicacionesNegocio: List<PublicacionesNegocio>.from(
            json["publicaciones_negocio"]
                .map((x) => PublicacionesNegocio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inicial_negocio": inicialNegocioValues.reverse[inicialNegocio],
        "inicial_negocio": inicialNegocio,
        "ruc": ruc,
        "negocio": negocioValues.reverse[negocio],
        "negocio": negocio,
        "telefono": telefono,
        "provincia": provincia,
        "canton": canton,
        "ubicacion": ubicacion,
        "foto": foto,
        "servicios": List<dynamic>.from(servicios.map((x) => x.toJson())),
        "personal": List<dynamic>.from(personal.map((x) => x.toJson())),
        "publicaciones_negocio":
            List<dynamic>.from(publicacionesNegocio.map((x) => x.toJson())),
      };
}

enum InicialNegocio { B }

final inicialNegocioValues = EnumValues({"B": InicialNegocio.B});

enum Negocio { BIODENT }

final negocioValues = EnumValues({"biodent": Negocio.BIODENT});

class Personal {
  Personal({
    this.correoDoctor,
    this.cedulaDoctor,
    this.nombreDoctor,
    this.rolDoctor,
    this.profesionDoctor,
    this.celularDoctor,
    this.sexoDoctor,
    this.fotoPerfil,
  });

  String correoDoctor;
  String cedulaDoctor;
  String nombreDoctor;
  String rolDoctor;
  String profesionDoctor;
  String celularDoctor;
  String sexoDoctor;
  String fotoPerfil;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        correoDoctor: json["correo_doctor"],
        cedulaDoctor: json["cedula_doctor"],
        nombreDoctor: json["nombre_doctor"],
        rolDoctor: json["rol_doctor"],
        profesionDoctor: json["profesion_doctor"],
        celularDoctor: json["celular_doctor"],
        sexoDoctor: json["sexo_doctor"],
        fotoPerfil: json["foto_perfil"],
      );

  Map<String, dynamic> toJson() => {
        "correo_doctor": correoDoctor,
        "cedula_doctor": cedulaDoctor,
        "nombre_doctor": nombreDoctor,
        "rol_doctor": rolDoctor,
        "profesion_doctor": profesionDoctor,
        "celular_doctor": celularDoctor,
        "sexo_doctor": sexoDoctor,
        "foto_perfil": fotoPerfil,
      };
}

class PublicacionesNegocio {
  PublicacionesNegocio({
    this.usuario,
    this.descripcion,
    this.archivo,
    this.fecha,
    this.negocio,
    this.inicialNegocio,
    this.inicialUsuario,
    this.fotoPerfil,
    this.idPublicacion,
  });

  Usuario usuario;
  String descripcion;
  String archivo;
  DateTime fecha;
  Negocio negocio;
  InicialNegocio inicialNegocio;
  InicialUsuario inicialUsuario;
  String fotoPerfil;
  String idPublicacion;

  factory PublicacionesNegocio.fromJson(Map<String, dynamic> json) =>
      PublicacionesNegocio(
        usuario: usuarioValues.map[json["usuario"]],
        descripcion: json["descripcion"],
        archivo: json["archivo"],
        fecha: DateTime.parse(json["fecha"]),
        negocio: negocioValues.map[json["negocio"]],
        inicialNegocio: inicialNegocioValues.map[json["inicial_negocio"]],
        inicialUsuario: inicialUsuarioValues.map[json["inicial_usuario"]],
        fotoPerfil: json["foto_perfil"],
        idPublicacion: json["id_publicacion"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuarioValues.reverse[usuario],
        "descripcion": descripcion,
        "archivo": archivo,
        "fecha": fecha.toIso8601String(),
        "negocio": negocioValues.reverse[negocio],
        "inicial_negocio": inicialNegocioValues.reverse[inicialNegocio],
        "inicial_usuario": inicialUsuarioValues.reverse[inicialUsuario],
        "foto_perfil": fotoPerfil,
        "id_publicacion": idPublicacion,
      };
}

enum InicialUsuario { FM, MG, LC }

final inicialUsuarioValues = EnumValues({
  "FM": InicialUsuario.FM,
  "LC": InicialUsuario.LC,
  "MG": InicialUsuario.MG
});

enum Usuario { FREDDY_MURILLO, MICHAEL_IVAN_GARCIA_CABRERA, LAAA_CEDEO }

final usuarioValues = EnumValues({
  "Freddy Murillo": Usuario.FREDDY_MURILLO,
  "lañaña cedeño": Usuario.LAAA_CEDEO,
  "Michael Ivan Garcia Cabrera": Usuario.MICHAEL_IVAN_GARCIA_CABRERA
});

class Servicio {
  Servicio({
    this.idServicio,
    this.servicio,
    this.duracion,
    this.costo,
    this.imagenServicio,
  });

  String idServicio;
  String servicio;
  String duracion;
  String costo;
  String imagenServicio;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        idServicio: json["id_servicio"],
        servicio: json["servicio"],
        duracion: json["duracion"],
        costo: json["costo"],
        imagenServicio: json["imagen_servicio"],
      );

  Map<String, dynamic> toJson() => {
        "id_servicio": idServicio,
        "servicio": servicio,
        "duracion": duracion,
        "costo": costo,
        "imagen_servicio": imagenServicio,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
