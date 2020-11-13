// Generated by https://quicktype.io

class LikeState {
  List<EstadoReaccion> items = new List();
  LikeState.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final estado = new EstadoReaccion.fromJsonMap(item);
      items.add(estado);
      // print(publicacion.comentarios.length);
    }
  }
}

class EstadoReaccion {
  String estado;

  EstadoReaccion({
    this.estado,
  });

  EstadoReaccion.fromJsonMap(Map<String, dynamic> json) {
    estado = json['estado'];
  }
}