import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class ServicesPages extends StatefulWidget {
  @override
  _ServicesPagesState createState() => _ServicesPagesState();
}

class _ServicesPagesState extends State<ServicesPages> {
  final formkey = new GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  File foto;
  String fotopath;

  String descripcion, duracion;
  String businessRuc;
  bool validate(String value) {
    return true;
  }
  

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appMenu(screenSize),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                _mostrarImagen(screenSize),
                SizedBox(
                  height: 15,
                ),
                 textFieldDescripcion(screenSize),
                 SizedBox(
                  height: 15,
                ),
                textFieldDuracion(screenSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldDescripcion(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      child: new TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Descripcion",
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
        maxLines: 2,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese un localizacion válido'
                : null,
        onSaved: (value) => this.descripcion = value,
      ),
    );
  }
  Widget textFieldDuracion(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.85,
      child: new TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: "Duracion",
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
        maxLines: 1,
        validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
                ? 'Ingrese un localizacion válido'
                : null,
        onSaved: (value) => this.duracion = value,
      ),
    );
  }

 Widget selectBox(Size sizescreen){


}

  Widget _mostrarImagen(Size screenSize) {
    if (foto != null) {
      return Stack(
        alignment: Alignment(0.95, 0.99),
        children: <Widget>[
          Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
                foto,
                fit: BoxFit.cover,
                // height: 300.0,
              ),
            ),
          ),
          Row(
            children: [
              CircleButton(
                icon: Icons.add_a_photo_outlined,
                iconsize: 30,
                colorIcon: Colors.blue[600],
                colorBorde: Colors.lightBlue[50],
                onPressed: () {
                  _ingresarImagen(ImageSource.camera);
                },
              ),
              CircleButton(
                icon: Icons.image_search,
                iconsize: 30,
                colorIcon: Colors.blue[600],
                colorBorde: Colors.lightBlue[50],
                onPressed: () {
                  _ingresarImagen(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      );
    }
    return Stack(
      alignment: Alignment(1, 0.99),
      children: <Widget>[
        Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/upload.png'))),
        Row(
          children: [
            CircleButton(
              icon: Icons.add_a_photo_outlined,
              iconsize: 30,
              colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
              onPressed: () {
                _ingresarImagen(ImageSource.camera);
              },
            ),
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            CircleButton(
              icon: Icons.image_search,
              iconsize: 30,
              colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
              onPressed: () {
                _ingresarImagen(ImageSource.gallery);
              },
            ),
          ],
        ),
        // IconButton(
        //     icon: Icon(Icons.add_a_photo),
        //     onPressed: () {
        //       _ingresarImagen();
        //     })
      ],
    );
    // return Container();
  }

  _ingresarImagen(ImageSource tipo) async {
    foto = await ImagePicker.pickImage(source: tipo);
    if (foto != null) {
      setState(() {
        fotopath = foto.path;
      });
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
