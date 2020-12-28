class Servicios{
  int servicioid;
  String descripcion;

  Servicios({this.descripcion = '', this.servicioid});

  factory Servicios.fromJson(Map<String, dynamic> json) {
    return Servicios(
      descripcion:           json['descripcion'],
      servicioid:            int.parse(json['servicio_id'].toString())
    );
  }
}