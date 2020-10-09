// To parse this JSON data, do
//
//     final newsUser = newsUserFromJson(jsonString);

import 'dart:convert';

NewsUser newsUserFromJson(String str) => NewsUser.fromJson(json.decode(str));

String newsUserToJson(NewsUser data) => json.encode(data.toJson());

class NewsUser {
  NewsUser({
    this.jsontype,
    this.usuario,
  });

  String jsontype;
  List<Usuario> usuario;

  factory NewsUser.fromJson(Map<String, dynamic> json) => NewsUser(
        jsontype: json["jsontype"],
        usuario:
            List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jsontype": jsontype,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
      };
}

class Usuario {
  Usuario({
    this.userEmail,
    this.passwordUser,
    this.userDni,
    this.userNames,
    this.userLastNames,
    this.birthdate,
    this.cellphone,
    this.sex,
    this.userType,
    this.profession,
  });

  String userEmail;
  String passwordUser;
  String userDni;
  String userNames;
  String userLastNames;
  String birthdate;
  String cellphone;
  Sex sex;
  UserType userType;
  String profession;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        userEmail: json["user_email"],
        passwordUser: json["password_user"],
        userDni: json["user_dni"],
        userNames: json["user_names"],
        userLastNames: json["user_last_names"],
        birthdate: json["birthdate"],
        cellphone: json["cellphone"],
        sex: sexValues.map[json["sex"]],
        userType: userTypeValues.map[json["user_type"]],
        profession: json["profession"] == null ? null : json["profession"],
      );

  Map<String, dynamic> toJson() => {
        "user_email": userEmail,
        "password_user": passwordUser,
        "user_dni": userDni,
        "user_names": userNames,
        "user_last_names": userLastNames,
        "birthdate": birthdate,
        "cellphone": cellphone,
        "sex": sexValues.reverse[sex],
        "user_type": userTypeValues.reverse[userType],
        "profession": profession == null ? null : profession,
      };
}

enum Sex { M, F }

final sexValues = EnumValues({"F": Sex.F, "M": Sex.M});

enum UserType { D, P }

final userTypeValues = EnumValues({"D": UserType.D, "P": UserType.P});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
