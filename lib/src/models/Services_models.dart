// To parse this JSON data, do
//
//     final businessService = businessServiceFromJson(jsonString);

import 'dart:convert';

BusinessService businessServiceFromJson(String str) =>
    BusinessService.fromJson(json.decode(str));

String businessServiceToJson(BusinessService data) =>
    json.encode(data.toJson());

class BusinessService {
  BusinessService({
    this.jsontype,
    this.servicios,
  });

  String jsontype;
  List<Servicio> servicios = new List();

  factory BusinessService.fromJson(Map<String, dynamic> json) =>
      BusinessService(
        jsontype: json["jsontype"],
        servicios: List<Servicio>.from(
            json["servicios"].map((x) => Servicio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jsontype": jsontype,
        "servicios": List<dynamic>.from(servicios.map((x) => x.toJson())),
      };
}

class Servicio {
  Servicio({
    this.servicioId,
    this.negocioRuc,
    this.descripcion,
    this.duracion,
    this.costo,
    this.urlImagen,
    this.preguntasFrecuentes,
  });

  String servicioId;
  String negocioRuc;
  String descripcion;
  String duracion;
  String costo;
  String urlImagen;
  List<PreguntasFrecuente> preguntasFrecuentes;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        servicioId: json["servicio_id"],
        negocioRuc: json["negocio_ruc"],
        descripcion: json["descripcion"],
        duracion: json["duracion"],
        costo: json["costo"],
        urlImagen: json["url_imagen"],
        preguntasFrecuentes: List<PreguntasFrecuente>.from(
            json["Preguntas_frecuentes"]
                .map((x) => PreguntasFrecuente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "servicio_id": servicioId,
        "negocio_ruc": negocioRuc,
        "descripcion": descripcion,
        "duracion": duracion,
        "costo": costo,
        "url_imagen": urlImagen,
        "Preguntas_frecuentes":
            List<dynamic>.from(preguntasFrecuentes.map((x) => x.toJson())),
      };
}

class PreguntasFrecuente {
  PreguntasFrecuente({
    this.preguntasFrecuenteId,
    this.descripcion,
    this.respuesta,
  });

  String preguntasFrecuenteId;
  String descripcion;
  String respuesta;

  factory PreguntasFrecuente.fromJson(Map<String, dynamic> json) =>
      PreguntasFrecuente(
        preguntasFrecuenteId: json["preguntas_frecuente_id"],
        descripcion: json["descripcion"],
        respuesta: json["respuesta"],
      );

  Map<String, dynamic> toJson() => {
        "preguntas_frecuente_id": preguntasFrecuenteId,
        "descripcion": descripcion,
        "respuesta": respuesta,
      };
}
