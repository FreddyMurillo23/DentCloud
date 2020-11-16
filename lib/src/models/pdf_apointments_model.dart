 class PDFModelApointment{
   String descripcion;
   String tipo;
   String url;
   DateTime fechaCarga;
   String idCita;
   String correoPaciente;
   String nombrePaciente;
   String foto;
   DateTime fechaCita;

   PDFModelApointment({
     this.descripcion='', 
     this.fechaCarga, 
     this.tipo='', 
     this.url='',
     this.correoPaciente = '',
     this.fechaCita,
     this.foto = '',
     this.idCita = '',
     this.nombrePaciente = ''
     
    });

   factory PDFModelApointment.fromJson(Map<String, dynamic> json) {
    return PDFModelApointment(
      descripcion:      json['descripcion'],
      fechaCarga:       DateTime.parse(json['fecha_carga'].toString()),
      url:              json['link'],
      tipo:             json['tipo_documento'],
      correoPaciente:   json['correo_paciente'],
      fechaCita:        DateTime.parse(json['fecha_cita'].toString()),
      foto:             json['foto_paciente'],
      idCita:           json['id_cita'],
      nombrePaciente:   json['nombre_paciente'],
    );
  }

 }