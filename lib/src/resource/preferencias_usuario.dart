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

  set profileName(String nombre) {
    _prefs.setString('profileName', nombre);
  }

  set profileID(String id) {
    _prefs.setString('profileId', id);
  }

  get profileName {
    if (_prefs.getString('profileName') != null) {
      return _prefs.getString('profileName');
    } else {
      return 'error';
    }
  }

  get profileID {
    if (_prefs.getString('profileId') != null) {
      return _prefs.getString('profileId');
    } else {
      return 'error';
    }
  }

  //! Actual perfil que corre en la app
  set currentProfile(bool value) {
    _prefs.setBool('currentProfile', value);
  }

  get currentProfile {
    if (_prefs.getBool('currentProfile') != null) {
      return _prefs.getBool('currentProfile');
    } else {
      return true;
    }
  }

  //! Tipo de perfil RUC o CORREO
  //* TRUE = correo False = RUC
  set thisProfileType(bool type) {
    _prefs.setBool('profileType', type);
  }

  get thisProfileType {
    if (_prefs.getBool('profileType') != null) {
      return _prefs.getBool('profileType');
    } else {
      return true;
    }
  }
}
