import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //! Datos del correo actual en la app
  get currentCorreo async {
    return _prefs.getString('currentCorreo') ?? 'empty';
  }

  set currentCorreo(String value) {
    _prefs.setString('currentCorreo', value);
  }

//! Contrasena actual en la app
  get currentPassword async {
    return _prefs.getString('currentPassword') ?? 'empty';
  }

  set currentPassword(String value) {
    _prefs.setString('currentPassword', value);
  }

//! Borra los datos del usuario de la app para volver a cargar en login
  get resetCurrentUserData async {
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

  //! Actual perfil que corre en la app
  set currentProfile(String value) {
    _prefs.setString('currentProfile', value);
  }

  get currentProfile async {
    return _prefs.getString('currentProfile') ?? 'empty';
  }

  //! Tipo de perfil RUC o CORREO
  set profileType(String type) {
    print(identical('1256984541', '1304924424'));
  }
}
