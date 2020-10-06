class CurrentUsuarios {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<CurrentUsuario> items = new List();

  // Publicaciones()
  
  CurrentUsuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final usuario = new CurrentUsuario.fromJsonMap(item);
      items.add(usuario);
    }
  }
}

class CurrentUsuario {
  String correo;
  String cedula;
  String nombres;
  String apellidos;
  String fechaNacimiento;
  String celular;
  String sexo;
  String tipoUsuario;

  CurrentUsuario({
    this.correo,
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.celular,
    this.sexo,
    this.tipoUsuario,
  });
  CurrentUsuario.fromJsonMap(Map<String, dynamic> json) {
    correo = json['correo'];
    cedula = json['cedula'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    fechaNacimiento = json['fecha-nacimiento'];
    celular = json['celular'];
    sexo = json['sexo'];
    tipoUsuario = json['tipo_usuario'];
  }
  
}
