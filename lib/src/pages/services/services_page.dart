import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class ServicesPages extends StatefulWidget {
  @override
  _ServicesPagesState createState() => _ServicesPagesState();
}

class _ServicesPagesState extends State<ServicesPages> {
  final formkey = new GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  List<PreguntasFrecuente> datos = [];
  File foto;
  String fotopath;
  String selectName;
  String descripcion, duracion;
  String businessRuc;
  String pregunta;
  bool validate(String value) {
    return true;
  }

  List<UserTrabajos> data;

  loadData(CurrentUsuario user) {
    data = user.userTrabajos;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    loadData(userinfo);
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
                SizedBox(
                  height: 15,
                ),
                selectBox(screenSize),
                SizedBox(
                  height: 15,
                ),
                preguntasFrecuentes(screenSize),
                 SizedBox(
                  height: 15,
                ),

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

  Widget selectBox(Size sizescreen) {
    return Container(
        //color: Colors.white,
        width: sizescreen.width * 0.85,
        child: Center(
          child: DropdownButtonFormField(
              value: selectName,
              //hint: Text('Seleccione el negocio'),
              style: new TextStyle(
                color: Colors.black,
                //fontSize: 18.0,
              ),
              //value: verificar(datos[0].sexo),
              isExpanded: true,
              items: data.map((list) {
                return DropdownMenuItem(
                  child: Text(list.nombreNegocio),
                  value: list.idNegocio,
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Este campo no puede estar vacío' : null,
              onChanged: (value) {
                setState(() {
                  // this.selectName=value;
                  this.businessRuc = value;
                  print(this.businessRuc);
                });
              },
              decoration: InputDecoration(
                labelText: "Negocio",
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

  Widget preguntasFrecuentes(Size sizescreen) {
    return Container(
    
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[500],
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(2.0, 10.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment(-0.80, -0.1),
              child: Text(
                'Preguntas Frecuentes ',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            cardNegocio(sizescreen),
            Container(
              height: 10,
              width: 10,
            ),
            cardListaPreguntas(sizescreen),
          ],
        ),
      ),
    );
  }


  Widget cardListaPreguntas(Size screenSize)
  {
   //if(datos.isEmpty)
   //{
     return Padding(padding: EdgeInsets.symmetric(vertical: 10),
     child: Container(
        height: screenSize.height * 0.20,
        alignment: Alignment.center,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (BuildContext context, index){
            return Column(
             children: [
               InputChip(
                label: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child: ExpansionTile(
                      title: Container(
                        child: Text('Preguntas1',style:
                        TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    leading:getIcon('Pregunta') ,
                    children: <Widget> [
                      Text('Que tal estuvo')
                    ],
                    ),
                ),
                onDeleted: (){
                  
                },
                deleteIcon:Icon(
                        Icons.highlight_remove,
                        color: Colors.white,
                      ), 
               ),
             ],
            );
            
          },
          
          ),
     ),
     
     );

  //  }
  //  else
  //  {
  //    return Container();
  //  }

  }

  
  Widget cardNegocio(Size sizescreen) {
    return Card(
      margin:
          new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: Column(
        children: [
          textfielPreguntas(sizescreen),
          SizedBox(
            height: 20,
          ),
          textfielRespuest(sizescreen),
          SizedBox(
            height: 20,
          ),
           buttonregistrar(sizescreen),
        ],
      ),
    );
  }

  Widget buttonregistrar(Size sizescreen) {
    return Row(
      children: [
        SizedBox(width: 20,),
        ButtonTheme(
          minWidth: sizescreen.width * 0.3,
                  child: RaisedButton(
            child: Text("Agregar"),
            //onPressed:validarregistrar,
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 50,),
         ButtonTheme(
           minWidth: sizescreen.width * 0.3,
                    child: RaisedButton(
            child: Text("Cancelar"),
            //onPressed:validarregistrar,
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            onPressed: () {},
        ),
         ),

      ],
    );
  }

  Widget textfielPreguntas(Size sizescreen) {
    return TextFormField(
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
      onSaved: (value) => this.pregunta = value,
    );
  }

  Widget textfielRespuest(Size sizescreen) {
    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: "Respuesta",
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
      onSaved: (value) => this.pregunta = value,
    );
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
