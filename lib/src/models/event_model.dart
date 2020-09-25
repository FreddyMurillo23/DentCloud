class Eventos{
  String paciente;
  DateTime fecha;
  String servicio;
  String descripcion;

  Eventos({this.paciente,this.fecha,this.servicio,this.descripcion});

  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
      paciente: json['paciente'],
      fecha: DateTime.parse(json['fecha'].toString()),
      servicio: json['servicio'],
      descripcion: json['descripcion']
    );
  }
}