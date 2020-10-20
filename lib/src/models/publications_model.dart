class PublicacionesByUser {
  List<Publicacion> items = new List();
  PublicacionesByUser.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new Publicacion.fromJsonMap(item);
      items.add(publicacion);
      // print(publicacion.comentarios.length);
    }
  }
}

class Publicaciones {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<Publicacion> items = new List();

  // Publicaciones()

  Publicaciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new Publicacion.fromJsonMap(item);
      items.add(publicacion);
      // print(publicacion.comentarios.length);
    }
  }
}

class Publicacion {
  String usuario;
  String correoUsuario;
  String descripcion;
  String archivo;
  DateTime fecha;
  String idPublicacion;
  String negocio;
  String negocioRuc;
  String inicialnegocio;
  String inicialusuario;
  String fotoperfilusuario;
  int likes;
  List<Etiquetas> etiquetas = new List();
  List<Comentarios> comentarios = new List();

  Publicacion({
    this.usuario,
    this.descripcion,
    this.fecha,
    this.archivo,
    this.negocio,
    this.inicialusuario,
    this.inicialnegocio,
    this.fotoperfilusuario,
    this.likes,
    this.etiquetas,
    this.comentarios,
  });
  //? /1 Para connvertir a double y .cast<int>() para lista de items
  //? fromJsonMap extrae los datos del json y los envia a las variables de la clase y los convierte en un mapa de datos.
  Publicacion.fromJsonMap(Map<String, dynamic> json) {
    usuario = json['usuario'];
    descripcion = json['descripcion'];
    archivo = json['archivo'];
    fecha = DateTime.parse(json['fecha'].toString());
    negocio = json['negocio'];
    inicialusuario = json['inicial_usuario'];
    inicialnegocio = json['inicial_negocio'];
    fotoperfilusuario = json['foto_perfil'];
    likes = int.parse(json['likes']);
    if (json['etiquetas'].length != 0) {
      for (var item in json['etiquetas']) {
        final eti = new Etiquetas.fromJsonMap(item);
        etiquetas.add(eti);
      }
    }
    if (json['comentarios'].length != 0) {
      for (var item in json['comentarios']) {
        final com = new Comentarios.fromJsonMap(item);
        comentarios.add(com);
      }
    }
    // print(fecha);
  }

  get imagenPublicacion {
    if (archivo == null) {
      return 'empty';
    } else {
      return archivo;
    }
  }

  get usuarioPublicacion {
    if (usuario == null) {
      return 'NO USER DATA';
    } else {
      return usuario;
    }
  }

  get descripcionPublicacion {
    if (descripcion == null) {
      return ' ';
    } else {
      return descripcion;
    }
  }

  get timeAgo {
    // print(fecha);
    if (fecha == null) {
      return '404 ';
    } else {
      DateTime now = new DateTime.now();
      final months = (now.difference(fecha).inDays / 30).round();
      final timeAgoDays = now.difference(fecha).inDays;
      final timeAgoHour = now.difference(fecha).inHours;
      final timeAgoMin = now.difference(fecha).inMinutes;
      final timeAgoSec = now.difference(fecha).inSeconds;
      if (months > 0 && timeAgoDays >= 31) {
        if (months == 1) {
          return 'Hace $months mes · ';
        }
        return 'Hace $months meses · ';
      }
      if (timeAgoDays > 0 && timeAgoDays < 31) {
        if (timeAgoDays == 1) {
          return 'Hace $timeAgoDays dia · ';
        }
        return 'Hace $timeAgoDays dias · ';
      }
      if (timeAgoHour > 0 && timeAgoDays == 0) {
        if (timeAgoHour == 1) {
          return 'Hace $timeAgoHour hora · ';
        }
        return 'Hace $timeAgoHour horas · ';
      }
      if (timeAgoMin > 0 && timeAgoHour == 0 && timeAgoDays == 0) {
        if (timeAgoMin == 1) {
          return 'Hace $timeAgoMin minuto · ';
        }
        return 'Hace $timeAgoMin minutos · ';
      }
      if (timeAgoSec > 0 &&
          timeAgoMin == 0 &&
          timeAgoDays == 0 &&
          timeAgoHour == 0) {
        if (timeAgoSec <= 10) {
          return 'Justo ahora ·';
        }
        return 'Hace $timeAgoSec segundos ·';
      }
    }
  }

  get comentariosCount {
    if (comentarios.length == 0) {
      return '0 Comentarios';
    } else {
      if (comentarios.length == 1) {
        return '${comentarios.length} Comentario';
      } else {
        return '${comentarios.length} Comentarios';
      }
    }
  }

  get likesCount {
    if (likes == 0) {
      return '$likes Me gusta';
    } else {
      return '$likes Me gusta';
    }
  }

  get negocioPublicacion {
    if (negocio == null) {
      return '404';
    } else {
      return negocio;
    }
  }

  get inicialNegocioPublicacion {
    if (inicialnegocio == null) {
      return '404';
    } else {
      return inicialnegocio;
    }
  }

  get inicialUsuarioPublicacion {
    if (inicialusuario == null) {
      return '404';
    } else {
      return inicialusuario;
    }
  }

  get fotoPerfilUsuarioPublicacion {
    if (fotoperfilusuario == null) {
      return '404';
    } else {
      return fotoperfilusuario;
    }
  }
}

class Comentarios {
  String publicationId;
  String comentaryId;
  String userEmail;
  DateTime comentaryDate;
  String comentaryDescription;
  Comentarios({
    this.publicationId,
    this.comentaryDate,
    this.comentaryDescription,
    this.comentaryId,
    this.userEmail,
  });
  Comentarios.fromJsonMap(Map<String, dynamic> json) {
    publicationId = json['publication_id'];
    comentaryId = json['commentary_id'];
    userEmail = json['user_email'];
    comentaryDate = DateTime.parse(json['commentary_date'].toString());
    comentaryDescription = json['commentary_description'];
  }
}

class Etiquetas {
  String idEtiqueta;
  String nombreUsuarioEtiquetado;
  String correoEtiquetado;
  String inicialUsuario;
  String publicacionId;
  Etiquetas({
    this.idEtiqueta,
    this.correoEtiquetado,
    this.inicialUsuario,
    this.nombreUsuarioEtiquetado,
    this.publicacionId,
  });
  Etiquetas.fromJsonMap(Map<String, dynamic> json) {
    idEtiqueta = json['id_etiqueta'];
    correoEtiquetado = json['correo_etiquetado'];
    inicialUsuario = json['inicial_usuario'];
    nombreUsuarioEtiquetado = json['nombre_usuario_etiquetado'];
    publicacionId = json['publicacion_id'];
  }
}
