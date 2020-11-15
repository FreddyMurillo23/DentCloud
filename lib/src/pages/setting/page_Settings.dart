import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final HttpService httpService = HttpService();
  final format = DateFormat("yyyy-MM-dd");
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  final formkey = new GlobalKey<FormState>();
  DataProvider businessData = new DataProvider();
  DataProvider1 businessData1 = new DataProvider1();

  void validarregistrar() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
       businessData1
        .actualizarBusines(businessRuc, businessName, businessPhone, province,
            canton, businessLocation, pathfoto, fotourl)
        .then((value) {
      if (value) {
        _showDialog();
      } else {}
    });
    }
   
  }

  // numero de Ruc
  bool validateNumber(String value) {
    if (value.length < 13) {
      return false;
    } else {
      return true;
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Actualizar Datos"),
          content: new Text("Se actualizo correctamente su perfil "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool validate(String value) {
    return true;
  }

  // Nombre de la empresa
  bool validateName(String value) {
    Pattern pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    return (!regExp.hasMatch(value)) ? false : true;
  }

  bool validateLocalizcion(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return (!regExp.hasMatch(value)) ? false : true;
  }

  // Telefono
  bool validatePhone(String value) {
    if (value.length < 10) {
      return false;
    } else {
      return true;
    }
  }

//  Usuario
//
//
//
//
  bool validateNumber1(String value) {
    if (value.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  void validarregistrar1() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      if (presiono == true) {
      if (sexo == "Masculino") {
        sexo = "M";
      } else {
        sexo = "F";
      }
    }
    else
    {
      sexo=sexopresion;
    }
    businessData1
        .actualizarUsuario(correo, contrasenia, nombres, apellidos, fecha,
            telefono, sexo, profesion, provincia, ciudad, fotourl, pathfoto)
        .then((value) {
      if (value) {
        _showDialog();
      } else {}
    });
    }
    
  }

  String businessRuc, businessName, businessPhone, province, canton;
  String businessLocation, email;
  String fotourl;
  var foto;
  String pathfoto;
//
//
//

  String cedula,
      nombres,
      apellidos,
      telefono,
      correo,
      sexo,
      provincia,
      ciudad,
      profesion;
  DateTime fecha;
  bool _obscureText = false, presiono = false;
  String sexopresion;
  String contrasenia;
  @override
  Widget build(BuildContext context) {
    final String enviado = ModalRoute.of(context).settings.arguments;

    final screenSize = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();

    if (prefs.currentCorreo != enviado) {
      return Scaffold(
        appBar: appMenu(screenSize),
        body: perfilNegocio(screenSize, enviado),
      );
    } else {
      return Scaffold(
        appBar: appMenu(screenSize),
        body: perfilUsuario(screenSize, enviado),
      );
    }
  }

  Widget appMenu(Size _screenSize) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,

      /*actions: <Widget>[
      CircleButton(
          icon: MdiIcons.forumOutline,
          iconsize: 30.0,
          onPressed: (){}, colorBorde: null, colorIcon: null,
          // onPressed: () => Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )
    ],*/
    );
  }

  Widget perfilNegocio(Size sizeScreen, String enviado) {
    return FutureBuilder(
        future: businessData.businessData(enviado),
        builder:
            (BuildContext context, AsyncSnapshot<List<NegocioData>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: sizeScreen.height * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fondo.jpg"), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          _mostrarfotoperfil(sizeScreen, snapshot.data),
                          //textFieldNombre(),
                          textFieldruc(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 15,
                          ),
                          textFieldNombre(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 15,
                          ),
                          textFieldprovincia(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 15,
                          ),
                          textFieldCiudad(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 15,
                          ),
                          textFieldPhone(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 15,
                          ),
                          textFieldLocation(sizeScreen, snapshot.data),
                          SizedBox(
                            height: 10,
                          ),
                          buttonRegistrar(sizeScreen),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget perfilUsuario(Size sizeScreen, String enviado) {
    return FutureBuilder(
        future: businessData.userData(enviado),
        builder: (BuildContext context,
            AsyncSnapshot<List<CurrentUsuario>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data[0].tipoUsuario == "D") {
              return Container(
                height: sizeScreen.height * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/fondo.jpg"), fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            mostrarfotoperfil1(sizeScreen, snapshot.data),
                            //textFieldNombre(),
                            textFieldcedula(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldCorreo(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldNombreUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldApellidoUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),

                            textFieldFechaUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldPhoneUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldSexo(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldprovinciaUsuario(
                                sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldCiudadUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFielpassword(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldprofesion(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            buttonRegistrarUsuario(sizeScreen),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: sizeScreen.height * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/fondo.jpg"), fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            mostrarfotoperfil1(sizeScreen, snapshot.data),
                            //textFieldNombre(),
                            textFieldcedula(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldCorreo(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldNombreUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldApellidoUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),

                            textFieldFechaUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldPhoneUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldSexo(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldprovinciaUsuario(
                                sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFieldCiudadUsuario(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            textFielpassword(sizeScreen, snapshot.data),
                            SizedBox(
                              height: 15,
                            ),
                            buttonRegistrarUsuario(sizeScreen),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buttonRegistrar(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.95,
      child: Row(
        children: [
          Container(
            width: sizescreen.width * 0.49,
            child: ButtonTheme(
              minWidth: sizescreen.width * 0.35,
              //height: sizescreen.height*0.056,
              child: Center(
                child: RaisedButton(
                  child: Text("Actualizar"),
                  onPressed: validarregistrar,
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: sizescreen.width * 0.45,
            child: Center(
              child: ButtonTheme(
                minWidth: sizescreen.width * 0.36,
                //height: sizescreen.height*0.056,
                child: RaisedButton(
                  child: Text("Cancelar"),
                  onPressed: () => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false)
                  },
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldruc(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      child: Center(
        child: TextFormField(
          readOnly: true,
          initialValue: datos[0].ruc,
          maxLength: 13,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            labelText: "RUC",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.camera_front),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateNumber(value)
                  ? 'Ingrese un Ruc correcto'
                  : null,
          onSaved: (value) => this.businessRuc = value,
        ),
      ),
    );
  }

  Widget textFieldLocation(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].ubicacion,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Localizacion",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validate(value)
                  ? 'Ingrese un localizacion válido'
                  : null,
          onSaved: (value) => this.businessLocation = value,
        ),
      ),
    );
  }

  Widget textFieldNombre(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].negocio,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Nombre empresa",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validate(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.businessName = value,
        ),
      ),
    );
  }

  Widget textFieldprovincia(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].provincia,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Provincia",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese una Provincia válido'
                  : null,
          onSaved: (value) => this.province = value,
        ),
      ),
    );
  }

  Widget textFieldCiudad(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].canton,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Ciudad",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese un Ciudad válido'
                  : null,
          onSaved: (value) => this.canton = value,
        ),
      ),
    );
  }

  Widget textFieldPhone(Size sizescreen, List<NegocioData> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].telefono,
          autofocus: false,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Telefono",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validatePhone(value)
                  ? 'Ingrese un telefono válido'
                  : null,
          onSaved: (value) => this.businessPhone = value,
        ),
      ),
    );
  }

  Widget _mostrarfotoperfil(Size sizescreen, List<NegocioData> datos) {
    if (foto != null) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: sizescreen.width * 0.45,
                height: sizescreen.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/placeholder.png'),
                      image: FileImage(foto),
                      fit: BoxFit.cover),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: -13,
                right: -15,
                child: Container(
                  child: IconButton(
                    icon: Icon(MdiIcons.cameraPlus),
                    color: Colors.blue,
                    iconSize: 40,
                    onPressed: () {
                      _seleccionar(sizescreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      fotourl = datos[0].foto;
      return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: sizescreen.width * 0.45,
                height: sizescreen.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/placeholder.png'),
                      image: NetworkImage(datos[0].foto),
                      fit: BoxFit.cover),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: -11,
                right: -15,
                child: Container(
                  child: IconButton(
                    icon: Icon(MdiIcons.cameraPlus),
                    color: Colors.blue,
                    onPressed: () {
                      _seleccionar(sizescreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  _seleccionar(Size sizescreen) {
    return showGeneralDialog(
      barrierLabel: "Escoger la foto",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 250,
            width: 400,
            child: Stack(
              children: [
                Positioned(
                  bottom: -10,
                  left: 15,
                  child: Center(
                    child: Container(
                      color: Color(0x00000000),
                      width: 380,
                      height: 450,
                      child: Image(
                        image: AssetImage('assets/title.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 210,
                    left: 60,
                    child: Material(
                      child: Container(
                        child: GradientText(
                          'Camara',
                          gradient: LinearGradient(colors: [
                            Colors.green[200],
                            Colors.blue[200],
                            Colors.green[300]
                          ]),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 25,
                  left: 40,
                  child: Material(
                    color: Color(0x00000000),
                    child: IconButton(
                      icon: Icon(MdiIcons.camera),
                      iconSize: 100,
                      color: Colors.blue[200],
                      onPressed: () {
                        _selecionarfotoCamara();
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: 210,
                    left: 250,
                    child: Material(
                      child: Container(
                        child: GradientText(
                          'Galeria',
                          gradient: LinearGradient(colors: [
                            Colors.green[200],
                            Colors.blue[200],
                            Colors.green[300]
                          ]),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 25,
                  left: 230,
                  child: Material(
                    color: Color(0x00000000),
                    child: IconButton(
                      icon: Icon(Icons.photo),
                      iconSize: 100,
                      color: Colors.blue[200],
                      onPressed: () {
                        _selecionarfotoGalery();
                      },
                    ),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  _selecionarfotoGalery() async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        foto = picture;
        Navigator.of(context).pop();
        pathfoto = picture.path;
      }
    });
  }

  _selecionarfotoCamara() async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        foto = picture;
        Navigator.of(context).pop();
        pathfoto = picture.path;
      }
    });
  }

// usuario
//
//
  Widget mostrarfotoperfil1(Size sizescreen, List<CurrentUsuario> datos) {
    if (foto != null) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: sizescreen.width * 0.45,
                height: sizescreen.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/placeholder.png'),
                      image: FileImage(foto),
                      fit: BoxFit.cover),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: -13,
                right: -15,
                child: Container(
                  child: IconButton(
                    icon: Icon(MdiIcons.cameraPlus),
                    color: Colors.blue,
                    iconSize: 40,
                    onPressed: () {
                      _seleccionar(sizescreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      fotourl = datos[0].fotoPerfil;
      return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: sizescreen.width * 0.45,
                height: sizescreen.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/placeholder.png'),
                      image: NetworkImage(datos[0].fotoPerfil),
                      fit: BoxFit.cover),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: -11,
                right: -15,
                child: Container(
                  child: IconButton(
                    icon: Icon(MdiIcons.cameraPlus),
                    color: Colors.blue,
                    onPressed: () {
                      _seleccionar(sizescreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget textFieldcedula(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      child: Center(
        child: TextFormField(
          readOnly: true,
          initialValue: datos[0].cedula,
          maxLength: 13,
          autofocus: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            labelText: "Cedula",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.camera_front),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateNumber1(value)
                  ? 'Ingrese un Ruc correcto'
                  : null,
          onSaved: (value) => this.cedula = value,
        ),
      ),
    );
  }

  Widget textFieldNombreUsuario(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].nombres,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Nombres",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.nombres = value,
        ),
      ),
    );
  }

  Widget textFieldApellidoUsuario(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].apellidos,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Apellidos",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.apellidos = value,
        ),
      ),
    );
  }

  Widget textFieldFechaUsuario(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      child: Center(
          child: DateTimeField(
        initialValue: DateTime.parse(datos[0].fechaNacimiento),
        decoration: InputDecoration(
            labelText: "FechaNacimiento",
            filled: true,
            enabled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            prefixIcon: Icon(Icons.date_range)),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime.now());
        },
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return "Este campo no puede estar vacio";
          }
          if ((DateTime.now().year - dateTime.year) < 15) {
            return "La edad mínima es de 15 años";
          }
          return null;
        },
        onSaved: (DateTime dateTime) => this.fecha = dateTime,
      )),
    );
  }

  Widget textFieldPhoneUsuario(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].celular,
          autofocus: false,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Telefono",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validatePhone(value)
                  ? 'Ingrese un telefono válido'
                  : null,
          onSaved: (value) => this.telefono = value,
        ),
      ),
    );
  }

  Widget textFieldSexo(Size sizescreen, List<CurrentUsuario> datos) {
    sexopresion = datos[0].sexo;
    return Container(
        //color: Colors.white,
        width: sizescreen.width * 0.85,
        child: Center(
          child: DropdownButtonFormField(
              style: new TextStyle(
                color: Colors.black,
                //fontSize: 18.0,
              ),
              value: verificar(datos[0].sexo),
              isExpanded: true,
              items: <String>['Masculino', 'Femenino']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Este campo no puede estar vacío' : null,
              onChanged: (value) {
                this.sexo = value;
                setState(() {
                 
                  presiono = true;
                  this.sexo = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Sexo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black)),
                prefixIcon: Icon(Icons.accessibility),
                filled: true,
                fillColor: Colors.white,
              )),
        ));
  }

  Widget textFieldprovinciaUsuario( Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].provinciaResidencia,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Provincia",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese una Provincia válido'
                  : null,
          onSaved: (value) => this.provincia = value,
        ),
      ),
    );
  }

  Widget textFieldCiudadUsuario(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].ciudadResidencia,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Ciudad",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese un Ciudad válido'
                  : null,
          onSaved: (value) => this.ciudad = value,
        ),
      ),
    );
  }

  Widget textFieldCorreo(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          readOnly: true,
          initialValue: datos[0].correo,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Apellidos",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validate(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.correo = value,
        ),
      ),
    );
  }

  Widget textFielpassword(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      child: Center(
        child: TextFormField(
          initialValue: datos[0].userPassword,
          autofocus: false,
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
              prefixIcon: Icon(Icons.lock),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(this._obscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    this._obscureText = !this._obscureText;
                  });
                },
              )),
          onChanged: (value) => this.contrasenia = value,
          onFieldSubmitted: (value) => this.contrasenia = value,
          validator: (value) =>
              value.isEmpty ? 'Este campo no puede estar vacío' : null,
          onSaved: (value) => this.contrasenia = value,
        ),
      ),
    );
  }

  Widget buttonRegistrarUsuario(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.95,
      child: Row(
        children: [
          Container(
            width: sizescreen.width * 0.49,
            child: ButtonTheme(
              minWidth: sizescreen.width * 0.35,
              //height: sizescreen.height*0.056,
              child: Center(
                child: RaisedButton(
                  child: Text("Actualizar"),
                  onPressed: validarregistrar1,
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: sizescreen.width * 0.45,
            child: Center(
              child: ButtonTheme(
                minWidth: sizescreen.width * 0.36,
                //height: sizescreen.height*0.056,
                child: RaisedButton(
                  child: Text("Cancelar"),
                  onPressed: () => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false)
                  },
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldprofesion(Size sizescreen, List<CurrentUsuario> datos) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
          initialValue: datos[0].profesion,
          autofocus: false,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: "Profesion",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black)),
            prefixIcon: Icon(Icons.text_fields),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) => value.isEmpty
              ? 'Este campo no puede estar vacío'
              : !validateName(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.profesion = value,
        ),
      ),
    );
  }

  String verificar(String dato) {
    if (dato == "M") {
      return 'Masculino';
    } else {
      return 'Femenino';
    }
  }
}
