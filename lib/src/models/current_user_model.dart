class CurrentUsuarios {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<CurrentUsuario> items = new List();

  // Publicaciones()

  CurrentUsuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      // int count = jsonList.length;
      // print(count);
      final usuario = new CurrentUsuario.fromJsonMap(item);
      // print(item);
      items.add(usuario);
      // print(usuario);
      // for (var public in items[0].publicaciones) {
      //   print(public);
      //   // print(items[0].publicaciones[i]['id_publicacion']);
      // }
      // print(items[0].apellidos);
    }
    print(items[0].publicaciones[1].idPublicacion);
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
  String fotoPerfil;
  List<UserPublicacion> publicaciones = new List();
  List<ServiciosReciente> serviciosRecientes = new List();
  List<NegociosAsistido> negociosAsistidos = new List();
  List<UsuariosSeguido> usuariosSeguidos = new List();

  CurrentUsuario({
    this.correo,
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.celular,
    this.sexo,
    this.tipoUsuario,
    this.fotoPerfil,
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
    fotoPerfil = json['foto_perfil'];
    if (json == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in json['publicaciones']) {
      final pub = new UserPublicacion.fromJsonMap(item);
      // print(item);
      // print(pub.idPublicacion);
      publicaciones.add(pub);
      // print(json['publicaciones']);
    }
    // publicaciones.add(value)
  }
}

class UserPublicacion {
  String idPublicacion;

  UserPublicacion({
    this.idPublicacion,
  });
  UserPublicacion.fromJsonMap(Map<String, dynamic> json) {
    idPublicacion = json['id_publicacion'];
    // print(json);
  }
}

class NegociosAsistido {
  String negocio;

  NegociosAsistido({
    this.negocio,
  });
}

class Publicacione {
  String idPublicacion;

  Publicacione({
    this.idPublicacion,
  });
}

class ServiciosReciente {
  String idServicio;

  ServiciosReciente({
    this.idServicio,
  });
}

class UsuariosSeguido {
  String idSiguiendo;

  UsuariosSeguido({
    this.idSiguiendo,
  });
}
