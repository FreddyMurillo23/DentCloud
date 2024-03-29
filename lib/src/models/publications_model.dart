

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
    }
  }
}

class Publicacion {
  String usuario;
  String descripcion;
  String archivo;
  String fecha;
  String negocio;
  String inicialnegocio;
  String inicialusuario;
  String fotoperfilusuario;

  Publicacion({
    this.usuario,
    this.descripcion,
    this.fecha,
    this.archivo,
    this.negocio,
    this.inicialusuario,
    this.inicialnegocio,
    this.fotoperfilusuario,
  });
  //? /1 Para connvertir a double y .cast<int>() para lista de items
  //? fromJsonMap extrae los datos del json y los envia a las variables de la clase y los convierte en un mapa de datos.
  Publicacion.fromJsonMap(Map<String, dynamic> json) {
    usuario             = json['usuario'];
    descripcion         = json['descripcion'];
    archivo             = json['archivo'];
    fecha               = json['fecha'];
    negocio             = json['negocio'];
    inicialusuario      = json['inicial_usuario'];
    inicialnegocio      = json['inicial_negocio'];
    fotoperfilusuario   = json['foto_perfil'];
  }

  getImagenPublicacion() {
    if (archivo == null) {
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    } else {
      return archivo;
    }
  }

  getUsuarioPublicacion() {
    if (usuario == null) {
      return 'NO USER DATA';
    } else {
      return usuario;
    }
  }

  getDescripcionPublicacion() {
    if (descripcion == null) {
      return ' ';
    } else {
      return descripcion;
    }
  }

  getFechaPublicacion() {
    if (fecha == null) {
      return '0000-00-00 00:00:00';
    } else {
      return fecha;
    }
  }

  getNegocioPublicacion() {
    if (negocio == null) {
      return '404';
    } else {
      return negocio;
    }
  }

  getInicialNegocioPublicacion() {
    if (inicialnegocio == null) {
      return '404';
    } else {
      return inicialnegocio;
    }
  }

  getInicialUsuarioPublicacion() {
    if (inicialusuario == null) {
      return '404';
    } else {
      return inicialusuario;
    }
  }

  getFotoPerfilUsuarioPublicacion() {
    if (fotoperfilusuario == null) {
      return '404';
    } else {
      return fotoperfilusuario;
    }
  }
}
