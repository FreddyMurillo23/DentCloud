import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get currentCorreo async{
    return _prefs.getString('currentCorreo')?? 'empty';
  } 

  set currentCorreo(String value) {
    _prefs.setString('currentCorreo', value);
  }

  get currentPassword async{
    return _prefs.getString('currentPassword') ?? 'empty';
  }

  set currentPassword(String value) {
    _prefs.setString('currentPassword', value);
  }

  get resetCurrentUserData async{
    _prefs.remove('currentCorreo').then((value) {
      _prefs.remove('currentPassword').then((value2) {
        print(value);
        print(value2);
        if (value && value2) {
          return true;
        }
      });
    });
  }
}
