import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBusiness extends StatefulWidget {
  RegisterBusiness({Key key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  final formkey = new GlobalKey<FormState>();
  // numero de Ruc
  bool validateNumber(String value) {
    if (value.length < 13) {
      return false;
    } else {
      return true;
    }
  }
   
  // Nombre de la empresa
  bool validateName(String value) {
    Pattern pattern = r'(^[a-zA-Z ]*$)';
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

  var foto;
  String business_ruc, business_name, business_phone, province, canton;
  String business_location;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(sizeScreen),
      body: SingleChildScrollView(
              child: Column(
          children: [
            _mostrarfotoperfil(sizeScreen),
            //textFieldNombre(),
            textFieldruc(sizeScreen),
            SizedBox(height: 15,),
            textFieldNombre(sizeScreen),
            SizedBox(height: 15,),
            textFieldprovincia(sizeScreen),
             SizedBox(height: 15,),
            textFieldCiudad(sizeScreen),
            SizedBox(height: 15,),
            textFieldPhone(sizeScreen),
            SizedBox(height: 15,),
            
          ],
        ),
      ),
    );
  }

  Widget textFieldruc(Size sizescreen) {
    return Container(
       width: sizescreen.width*0.85,
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
          onSaved: (value) => this.business_ruc = value,
        ),
      ),
    );
  }

  Widget textFieldNombre(Size sizescreen) {
     return Container(
       width: sizescreen.width*0.85,
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
              : !validateName(value)
                  ? 'Ingrese un nombre válido'
                  : null,
          onSaved: (value) => this.business_name = value,
        ),
      ),
    );
  }

Widget textFieldprovincia(Size sizescreen){
 return Container(
       width: sizescreen.width*0.85,
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
          onSaved: (value) => this.business_name = value,
        ),
      ),
    );
}

Widget textFieldCiudad(Size sizescreen){
  return Container(
       width: sizescreen.width*0.85,
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
          onSaved: (value) => this.business_name = value,
        ),
      ),
    );

}


Widget textFieldPhone(Size sizescreen){
 return Container(
       width: sizescreen.width*0.85,
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
          onSaved: (value) => this.business_name = value,
        ),
      ),
    );
}

Widget textFieldlocation(Size sizescreen){
  return Container(
       width: sizescreen.width*0.85,
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
          onSaved: (value) => this.business_name = value,
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
            height: sizescreen.height * 0.28,
            width: sizescreen.width * 0.9,
            child: Stack(
              children: [
                Positioned(
                  bottom: -10,
                  left: 15,
                  child: Center(
                    child: Container(
                      color: Color(0x00000000),
                      width: sizescreen.width * 0.8,
                      height: sizescreen.height * 0.5,
                      child: Image(
                        image: AssetImage('assets/title.png'),
                      ),
                    ),
                  ),
                ),
                /*SizedBox.expand(
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),*/
                Positioned(
                  bottom: 25,
                  left: 30,
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
                  bottom: 25,
                  left: 200,
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
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      foto = picture;
      Navigator.of(context).pop();
    });
  }

  _selecionarfotoCamara() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      foto = picture;
      Navigator.of(context).pop();
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
