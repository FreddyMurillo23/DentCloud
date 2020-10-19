import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/logo_login.dart';
// import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  final currentUserData = new PreferenciasUsuario();
  bool _obscureText = false;

//Validación
  void validaterField() {
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();
      print("Form is valid");
    } else {
      print('Form is invalid');
    }
//Prueba Temporal
    if (_email.isNotEmpty && _password.isNotEmpty) {
      
        final login = new DataProvider();
        login.loginUsuario(_email, _password).then((value) {
          if (value) {
            login.userData(_email).then((value) {
              if (value.isNotEmpty) {
                Navigator.pushReplacementNamed(context, 'startuppage',arguments: value[0]);
              } else {
                print("Error");
              }
            });
          } else {
            print("Error");
            _showDialog();
          }
        });
    }
  }

//Alerta
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Datos Erroneos Onichan"),
            content: new Image(
              image: AssetImage("assets/fondo2.png"),
              width: 150,
              height: 200,
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false)
                      },
                  child: new Text("Aceptar"))
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._obscureText = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),

      body: new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo.jpg"),fit: BoxFit.cover),
        ),
        child: new Center(
          child: new Container(
            height: 450,
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.white30, borderRadius: BorderRadius.circular(70)),
            child: new Form(
              key: formkey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),

                  LogoContainer(),

                  SizedBox(
                    height: 20,
                  ),

                  //TextField Email
                  new TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Correo Electrónico",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(Icons.mail),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) => value.isEmpty
                          ? 'El email no puede estar vacío'
                          : null,
                      onSaved: (value) => _email = value),

                  SizedBox(
                    height: 8,
                  ),

                  //TextField Password
                  new TextFormField(
                    obscureText: !this._obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(Icons.vpn_key),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                            icon: Icon(
                              this._obscureText
                              ? Icons.visibility
                              : Icons.visibility_off
                            ),
                            onPressed: () {
                              setState(() {
                                this._obscureText = !this._obscureText;
                              });
                            },
                          )
                        ),
                    validator: (value) => value.isEmpty
                        ? 'La contraseña no puede estar vacía'
                        : null,
                    onSaved: (value) => _password = value,
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  //SignIn Button
                  new RaisedButton(
                    child: Text("Iniciar Sesión"),
                    onPressed: validaterField,
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  //SignUp Button
                  new RaisedButton(
                    child: Text("Registrarse"),
                    onPressed: () => {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'signup', (Route<dynamic> route) => false)
                    },
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
