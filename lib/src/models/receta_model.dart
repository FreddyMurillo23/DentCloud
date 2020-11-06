class Receta{
  String medicina;
  String dosificacion;
  String presentacion;
  String prescripcion;

  Receta({this.medicina = '', this.dosificacion = '', this.prescripcion = '', this.presentacion = ''});

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      medicina:           json['medicina'],
      dosificacion:           json['dosificacion'],
      prescripcion:           json['prescripcion'],
      presentacion:           json['presentacion'],
    );
  }
}