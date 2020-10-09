class Usuarios {
  //? Lista de tipo publicacion donde se almacenaran los datos extraidos.
  List<Usuario> items = new List();

  // Publicaciones()

  Usuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final usuario = new Usuario.fromJsonMap(item);
      items.add(usuario);
    }
  }
}

class Usuario {
  String correo;
  String userPassword;
  String cedula;
  String nombres;
  String apellidos;
  String fechaNacimiento;
  String celular;
  String sexo;
  String tipoUsuario;
  String fotoPerfil;
  List<Publicacione> publicaciones;
  List<ServiciosReciente> serviciosRecientes;
  List<NegociosAsistido> negociosAsistidos;

  Usuario({
    this.correo,
    this.userPassword,
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.celular,
    this.sexo,
    this.tipoUsuario,
    this.fotoPerfil,
    this.publicaciones,
    this.serviciosRecientes,
    this.negociosAsistidos,
  });
  Usuario.fromJsonMap(Map<String, dynamic> json) {
    correo = json['correo'];
    userPassword = json['userPassword'];
    cedula = json['cedula'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    fechaNacimiento = json['fechaNacimiento'];
    celular = json['celular'];
    sexo = json['sexo'];
    tipoUsuario = json['tipoUsuario'];
    fotoPerfil = json['fotoPerfil'];
    publicaciones = json['publicaciones'].cast<String>();
    serviciosRecientes = json['serviciosRecientes'].cast<String>();
    negociosAsistidos = json['negociosAsistidos'].cast<String>();
  }
  getCorreo() {
    if (correo == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return correo;
    }
  }

  getuserPAssword() {
    if (userPassword == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return userPassword;
    }
  }

  getCedula() {
    if (cedula == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return cedula;
    }
  }
  getNombres() {
    if (nombres== null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return nombres;
    }
  }
  getApellidos() {
    if (apellidos == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return apellidos;
    }
  }
  getFechaDeNacimiento() {
    if (fechaNacimiento == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return fechaNacimiento;
    }
  }
  getCelular() {
    if (celular == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return celular;
    }
  }
  getSexo() {
    if (sexo == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return sexo;
    }
  }
  getTipoUsuario() {
    if (tipoUsuario == null) {
      return 'ERROR!! ERROR CODE 404';
    } else {
      return tipoUsuario;
    }
  }
  getFotoPerfil() {
    if (fotoPerfil == null) {
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    } else {
      return fotoPerfil;
    }
  }
  getPublicaciones() {
    if (publicaciones == null) {
      List<String> pub = new List();
      return pub;
    } else {
      return publicaciones;
    }
  }
  getServiciosRecientes() {
    if (serviciosRecientes == null) {
      List<String> sr = new List();
      return sr;
    } else {
      return serviciosRecientes;
    }
  }
  getNegociosAsistidos() {
    if (negociosAsistidos == null) {
      List<String> na = new List();
      return na;
    } else {
      return negociosAsistidos;
    }
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
