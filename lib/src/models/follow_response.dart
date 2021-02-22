class FollowStateList {
  List<FollowState> items = new List();
  FollowStateList.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //? Por cada item que recibe los va enviando al metodo que extrae los datos del json y retorna el mapa luego los agrega a una lista de items de tipo publicacion.
    for (var item in jsonList) {
      final follow = new FollowState.fromJsonMap(item);
      items.add(follow);
      // print(publicacion.comentarios.length);
    }
  }
}

class FollowState {
  bool status;
  FollowState({
    this.status,
  });
  FollowState.fromJsonMap(Map<String, dynamic> json) {
    try {
      if (json.containsKey('status')) {
        if (json['status'] != null) {
          if (json['status'] == 'A') {
            status = true;
          } else {
            status = false;
          }
        } else {
          status = false;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
