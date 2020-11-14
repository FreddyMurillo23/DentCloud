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
  get itemsList {
    return items;
  }

  CurrentUsuarios.clearItems() {
    items.clear();
  }
}

class ProfileUser {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<CurrentUsuario> items = new List();

  // Publicaciones()

  ProfileUser.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final usuario = new CurrentUsuario.fromJsonMap(item);
      items.add(usuario);
    }
  }
  get itemsList {
    return items;
  }

  ProfileUser.clearItems() {
    items.clear();
  }
}

class CurrentUsuario {
  String correo;
  String cedula;
  String userPassword;
  String nombres;
  String apellidos;
  String fechaNacimiento;
  String celular;
  String sexo;
  String tipoUsuario;
  String fotoPerfil;
  String profesion;
  String provinciaResidencia;
  String ciudadResidencia;
  List<UserPublicacion> publicaciones = new List();
  List<ServiciosReciente> serviciosRecientes = new List();
  List<NegociosAsistido> negociosAsistidos = new List();
  List<UsuariosSeguido> usuariosSeguidos = new List();
  List<UserTrabajos> userTrabajos = new List();

  CurrentUsuario(
      {this.correo,
      this.cedula,
      this.userPassword,
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
      this.userTrabajos,
      this.ciudadResidencia,
      this.profesion,
      this.provinciaResidencia});
  CurrentUsuario.fromJsonMap(Map<String, dynamic> json) {
    correo = json['correo'];
    userPassword=json['user_password'];
    cedula = json['cedula'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    fechaNacimiento = json['fecha_nacimiento'];
    celular = json['celular'];
    sexo = json['sexo'];
    tipoUsuario = json['tipo_usuario'];
    fotoPerfil = json['foto_perfil'];
    ciudadResidencia = json['ciudad_residencia'];
    profesion = json['profesion'];
    provinciaResidencia = json['provincia_residencia'];  

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
    if (json['trabajos'].length != 0) {
      for (var item in json['trabajos']) {
        final us = new UserTrabajos.fromJsonMap(item);
        userTrabajos.add(us);
      }
    }

    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
  }
  get openUserTrabajos {
    return userTrabajos;
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
    return negociosAsistidos;
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

class UserTrabajos {
  String rolDoctor;
  String idNegocio;
  String nombreNegocio;
  String imagenNegocio;

  UserTrabajos({
    this.rolDoctor,
    this.idNegocio,
    this.nombreNegocio,
    this.imagenNegocio,
  });

  UserTrabajos.fromJsonMap(Map<String, dynamic> json) {
    rolDoctor = json['rol_doctor'];
    idNegocio = json['id_negocio'];
    nombreNegocio = json['nombre_negocio'];
    imagenNegocio = json['foto_negocio'];
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
