import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class ServicesPages extends StatefulWidget {
  @override
  _ServicesPagesState createState() => _ServicesPagesState();
}

class _ServicesPagesState extends State<ServicesPages> {
  final formkey = new GlobalKey<FormState>();
   final formkey1 = new GlobalKey<FormState>();
  TextEditingController controllerText = TextEditingController();
  TextEditingController controllerRespuesta = TextEditingController();
  List<PreguntasFrecuente> datos = new List();
  
  File foto;
  String fotopath;
  String selectName;
  String descripcion, duracion;
  String businessRuc;
  String pregunta,respuesta;
  bool validate(String value) {
    return true;
  }

  void ingresarPreguntas()
  {
    final datosanadido= new PreguntasFrecuente();
    final form=formkey1.currentState;
    if(form.validate())
    {
      form.save();
      datosanadido.descripcion=pregunta;
      datosanadido.respuesta=respuesta;
      datos.add(datosanadido);
      controllerText.clear();
      controllerRespuesta.clear();
    }
  }
  

  void ingresarservicio()
  {
    final form=formkey.currentState;
    if(form.validate())
    {
      form.save();
      
    }

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
            child: Column(
              children: [
                Form(
                  key: formkey,
                  child: 
                Column(
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
                  ],
                )   ),
                 Form(
                   key:formkey1  ,
                   child: preguntasFrecuentes(screenSize),
                 ),
                SizedBox(
                  height: 15,
                ),
               buttonRegistrar(screenSize)
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
                'Preguntas Frecuentes',
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



Future mostrarPreguntas(int index){
       return showDialog(
               context: context,
               builder: (_)=>
                  AlertDialog(
                  content: Builder(
                    builder: (context){
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return Container(
                              height: height*0.12,
                              width: width*0.45,
                              child: SingleChildScrollView(
                                                              child: Column(
                                  children: [
                                    Container(
                                       child: Text(datos[index].respuesta,
                                       //style: TextStyle(fontSize: 10),
                                       ),
                                    ),
                                   
                                  ],
                                ),
                              ),
                              //color: Colors.green,
                        );
                    },
                  ),
                  title: Text(datos[index].descripcion,
                   style: TextStyle(fontSize: 20)
                  ),
                  actions: [
                    TextButton(
                       child: Text('Aceptar'),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
      );
  }

  Widget cardListaPreguntas(Size screenSize){
   if(datos.length!=0)
   {
     return Padding(padding: EdgeInsets.symmetric(vertical: 10),
     child: Container(
        height: screenSize.height * 0.20,
        alignment: Alignment.center,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: datos.length,
          itemBuilder: (BuildContext context, index){
            return Column(
             children: [
               InputChip(
                label: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child: SingleChildScrollView(
                      child: Container(
                        child: ListTile(
                          trailing: Icon(MdiIcons.play),
                          title: Text(datos[index].descripcion,
                          style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          ),
                          onTap: (){
                             mostrarPreguntas(index);
                          },
                        ),
                      ),
                    ),
                ),
                onPressed: (){
                  print('si funciona ');
                },
                onDeleted: (){
                  setState(() {
                    datos.removeAt(index);
                    cardListaPreguntas(screenSize);
                  });
                  
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

   }
   else
   {
     return Container();
   }

  }

  
  Widget cardNegocio(Size sizescreen) {
    return Card(
      margin:
          new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: Column(
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleButton(
              icon: MdiIcons.read,
              iconsize: 20,
              colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
              onPressed: () {
                ingresarPreguntas();
              setState(() {

             cardListaPreguntas(sizescreen);
          });
              },
            ),
            CircleButton(
              icon: MdiIcons.closeCircleOutline,
              iconsize: 20,
              colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
              onPressed: () {
                 controllerText.clear();
               controllerRespuesta.clear();
              },
            ),
              ],
            ),
          textfielPreguntas(sizescreen),
          SizedBox(
            height: 20,
          ),
          textfielRespuest(sizescreen),
          SizedBox(
            height: 20,
          ),
           //buttonregistrar(sizescreen),
        ],
      ),
    );
  }


 Widget buttonRegistrar(Size sizescreen) {
    return Container(
      width: sizescreen.width*0.95,
      child: Row(
        children: [
          Container(
            width: sizescreen.width * 0.45,
            child: ButtonTheme(
             minWidth: sizescreen.width * 0.35,
             //height: sizescreen.height*0.056,
              child: Center(
                child: RaisedButton(
                  onPressed: (){
                    ingresarservicio();
                  },
                  child: Text("Registrar"),
                  //onPressed:validarregistrar,
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
                    Navigator.of(context).pop(false)
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


  Widget textfielPreguntas(Size sizescreen) {
    return TextFormField(
      maxLines: 2,
      controller: controllerRespuesta,
      autofocus: false,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: "Pregunta",
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
      controller: controllerText,
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
      onSaved: (value) => this.respuesta = value,
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
