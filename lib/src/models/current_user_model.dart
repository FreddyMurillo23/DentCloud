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
    // print(items[0]);
    // print(items.length);
    // print(items[0].apellidos);
  }
  get itemsList {
    return items;
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
    this.publicaciones,
    this.negociosAsistidos,
    this.serviciosRecientes,
    this.usuariosSeguidos,
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

    if (json['publicaciones'].length != 0) {
      for (var item in json['publicaciones']) {
        final pub = new UserPublicacion.fromJsonMap(item);
        // print(pub.idPublicacion);
        // print(json['publicaciones'].length);
        publicaciones.add(pub);
      }
    }
    if (json['negocios_asistidos'].length != 0) {
      for (var item in json['negocios_asistidos']) {
        final neg = new NegociosAsistido.fromJsonMap(item);
        negociosAsistidos.add(neg);
      }
    }
    if (json['servicios_recientes'].length != 0) {
      for (var item in json['servicios_recientes']) {
        final sa = new ServiciosReciente.fromJsonMap(item);
        serviciosRecientes.add(sa);
      }
    }
    if (json['usuarios_seguidos'].length != 0) {
      for (var item in json['usuarios_seguidos']) {
        final us = new UsuariosSeguido.fromJsonMap(item);
        usuariosSeguidos.add(us);
      }
    }

    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
  }
  get currentcorreo {
    if (correo == null) {
      return '404';
    } else {
      return correo;
    }
  }

  get currentcedula {
    if (cedula == null) {
      return '404';
    } else {
      return cedula;
    }
  }

  get currentnombres {
    if (nombres == null) {
      return '404';
    } else {
      return nombres;
    }
  }

  get currentapellidos {
    if (apellidos == null) {
      return '404';
    } else {
      return apellidos;
    }
  }

  get currentfechaNacimiento {
    if (fechaNacimiento == null) {
      return '404';
    } else {
      return fechaNacimiento;
    }
  }

  get currentcelular {
    if (celular == null) {
      return '404';
    } else {
      return celular;
    }
  }

  get currentsexo {
    if (sexo == null) {
      return '404';
    } else {
      return sexo;
    }
  }

  get currenttipoUsuario {
    if (tipoUsuario == null) {
      return '404';
    } else {
      return tipoUsuario;
    }
  }

  get currentfotoPerfil {
    if (fotoPerfil == null) {
      return '404';
    } else {
      return fotoPerfil;
    }
  }

  get currentPublicaciones {
    if (publicaciones.length == 0) {
      return '404';
    } else {
      return publicaciones;
    }
  }

  get currentServiciosRecientes {
    if (serviciosRecientes.length == 0) {
      return '404';
    } else {
      return serviciosRecientes;
    }
  }

  get currentNegociosAsistidos {
    if (negociosAsistidos.length == 0) {
      return '404';
    } else {
      return negociosAsistidos;
    }
  }

  get currentUsuariosSeguidos {
    if (usuariosSeguidos.length == 0) {
      return '404';
    } else {
      return usuariosSeguidos;
    }
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

  NegociosAsistido.fromJsonMap(Map<String, dynamic> json) {
    negocio = json['negocio'];
    // print(json);
  }
}

class ServiciosReciente {
  String idServicio;

  ServiciosReciente({
    this.idServicio,
  });
  ServiciosReciente.fromJsonMap(Map<String, dynamic> json) {
    idServicio = json['id_servicio'];
    // print(json);
  }
}

class UsuariosSeguido {
  String idSiguiendo;

  UsuariosSeguido({
    this.idSiguiendo,
  });
  UsuariosSeguido.fromJsonMap(Map<String, dynamic> json) {
    idSiguiendo = json['id_siguiendo'];
    // print(json);
  }
}
