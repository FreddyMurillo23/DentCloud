 class PDFModelApointment{
   String descripcion;
   String tipo;
   String url;
   DateTime fechaCarga;

   PDFModelApointment({this.descripcion='', this.fechaCarga, this.tipo='', this.url=''});

   factory PDFModelApointment.fromJson(Map<String, dynamic> json) {
    return PDFModelApointment(
      descripcion:      json['descripcion'],
      fechaCarga:       DateTime.parse(json['fecha_carga'].toString()),
      url:              json['link'],
      tipo:             json['tipo_documento'],
    );
  }

 }