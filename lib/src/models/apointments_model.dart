class EventModel{
  String servicio;
  String descripcion;
  String paciente;

  EventModel({this.servicio, this.descripcion, this.paciente});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      paciente: json['paciente'],
      servicio: json['servicio'],
      descripcion: json['descripcion'],     
    );
  }
}