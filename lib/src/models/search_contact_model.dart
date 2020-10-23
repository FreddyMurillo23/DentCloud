class Busqueda {
  String jsontype;
  List<BusquedaNombre> items=new List();
  Busqueda.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final publicacion = new BusquedaNombre.fromJsonMap(item);
      items.add(publicacion);
      // print(publicacion.comentarios.length);
    }
  }

 
}

class BusquedaNombre {
  String sala;
  String receptor;
  String emailReceptor;
  String foto;

  BusquedaNombre({
    this.sala,
    this.receptor,
    this.emailReceptor,
    this.foto,
  });
  BusquedaNombre.fromJsonMap(Map<String, dynamic> json) 
  {
    sala = json['sala'];
    receptor = json['receptor']; 
    emailReceptor=json['email_receptor'];
    foto=json['foto'];
    // print(fecha);
  }
}