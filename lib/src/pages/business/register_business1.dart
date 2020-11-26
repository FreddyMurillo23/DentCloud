import 'package:flutter/material.dart' show Align, Alignment, AppBar, AssetImage, Axis, BorderRadius, BorderSide, BoxDecoration, BoxFit, BoxShape, Brightness, BuildContext, ButtonTheme, Center, ClipRRect, Color, Colors, Column, Container, DecorationImage, EdgeInsets, FadeInImage, FileImage, FontWeight, Form, FormState, GlobalKey, Icon, IconButton, Icons, Image, InputDecoration, Key, LinearGradient, Material, MediaQuery, ModalRoute, Navigator, Offset, OutlineInputBorder, Padding, Positioned, Radius, RaisedButton, RoundedRectangleBorder, Route, Row, Scaffold, SingleChildScrollView, Size, SizedBox, SlideTransition, Stack, State, StatefulWidget, Text, TextCapitalization, TextFormField, TextInputType, TextStyle, Tween, Widget, showGeneralDialog;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';


class RegisterBusiness extends StatefulWidget {
  RegisterBusiness({Key key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  final formkey = new GlobalKey<FormState>();
   DataProvider businessData= new DataProvider();

  var foto;
  String pathfoto;
  void validarregistrar() {
    final form = formkey.currentState;
    if (form.validate()) 
    {
      form.save();
    }
  
    DataProvider.registrar_negocio(email, businessRuc, businessName, businessPhone, province, canton, businessLocation, pathfoto).then((value) {
     if(value){
       Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
     }
    });
  }

  // numero de Ruc
  bool validateNumber(String value) {
    if (value.length < 13) {
      return false;
    } else {
      return true;
    }
  }

  bool validate(String value){
     return true;
  }

  // Nombre de la empresa
  bool validateName(String value) {
   Pattern pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    return (!regExp.hasMatch(value)) ? false : true;
  }


bool validateLocalizcion(String value){
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
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


  String businessRuc, businessName, businessPhone, province, canton;
  String businessLocation,email;
  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    email=userinfo.correo;
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(sizeScreen),
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/fondo.jpg"),
          fit: BoxFit.cover
          ),       
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Form(
                key: formkey,
                        child: Column(
                  children: [
                    _mostrarfotoperfil(sizeScreen),
                    //textFieldNombre(),
                    textFieldruc(sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldNombre(sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldprovincia(sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldCiudad(sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldPhone(sizeScreen),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldLocation(sizeScreen),
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
      ),
    );
  }

  Widget buttonRegistrar(Size sizescreen) {
    return Container(
      width: sizescreen.width*0.95,
      child: Row(
        children: [
          Container(
            width: sizescreen.width * 0.49,
            child: ButtonTheme(
             minWidth: sizescreen.width * 0.35,
             //height: sizescreen.height*0.056,
              child: Center(
                child: RaisedButton(
                  child: Text("Registrar"),
                  onPressed:validarregistrar,
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
                    Navigator.of(context).pop()
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

  Widget textFieldruc(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      child: Center(
        child: TextFormField(
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

  Widget textFieldLocation(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
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

  Widget textFieldNombre(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
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

  Widget textFieldprovincia(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
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

  Widget textFieldCiudad(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
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

  Widget textFieldPhone(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      //padding:EdgeInsets.all(3),
      child: Center(
        child: TextFormField(
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

  

  Widget _mostrarfotoperfil(Size sizescreen) {
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
                      image: AssetImage('assets/placeholder.png'),
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
                      child: GradientText('Camara',
                      gradient: LinearGradient(
                      colors: [Colors.green[200], Colors.blue[200], Colors.green[300]]
                      ),
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
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
                      child: GradientText('Galeria',
                       gradient: LinearGradient(
                      colors: [Colors.green[200], Colors.blue[200], Colors.green[300]]
                      ),
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
      foto = picture;
      Navigator.of(context).pop();
      pathfoto=picture.path;
    });
  }

  _selecionarfotoCamara() async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      foto = picture;
      Navigator.of(context).pop();
      pathfoto=picture.path;
    });
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
      actions: <Widget>[
        /*CircleButton(
          icon: MdiIcons.forumOutline,
          iconsize: 30.0,
          onPressed: (){},
          // onPressed: () => Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )*/
      ],
    );
  }
}
