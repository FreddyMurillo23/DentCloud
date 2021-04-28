import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
class EditPageService extends StatefulWidget {
  @override
  _EditPageServiceState createState() => _EditPageServiceState();
}

class _EditPageServiceState extends State<EditPageService> {
  File foto;
  String fotopath;
  final formkey = new GlobalKey<FormState>();
   final formkey1 = new GlobalKey<FormState>();
    DataProvider1 servicesProvider = new DataProvider1();
  TextEditingController controllerRespuesta = TextEditingController();
  TextEditingController controllerPregunta = TextEditingController();
  GlobalKey<FormState> _formtext = new GlobalKey<FormState>();
  List<PreguntasServicios> datos = new List();
  String pregunta, respuesta;
  ServiciosNegocio negocio;
   String descripcion, duracion;
   String ruc;
   bool activar=true;

 bool validate(String value) {
    return true;
  }
  _ingresarImagen(ImageSource tipo) async {
    foto = await ImagePicker.pickImage(source: tipo);
    if (foto != null) {
      setState(() {
        fotopath = foto.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
     final List<dynamic> objeto = ModalRoute.of(context).settings.arguments;
     loop(objeto[0]);
     ruc=objeto[1];
     negocio=objeto[0];
    return Scaffold(
      appBar: appMenu(screenSize),
      body:Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: Column(
              children: [
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        _mostrarImagen(screenSize,objeto[0]),
                        SizedBox(
                          height: 15,
                        ),
                        textFieldDescripcion(screenSize,objeto[0]),
                        SizedBox(
                          height: 15,
                        ),
                        textFieldDuracion(screenSize,objeto[0]),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
                Form(
                  key: formkey1,
                  child: preguntasFrecuentes(screenSize,objeto[0]),
                ),
                SizedBox(
                  height: 15,
                ),
                buttonRegistrar(screenSize)
              ],
            ),
          ),
        ),
      )

    );
  }
  Widget _mostrarImagen(Size screenSize, ServiciosNegocio businessSe) {
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
                child: Image.network(businessSe.imagenServicio))),
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
  Widget textFieldDescripcion(Size sizescreen,ServiciosNegocio businessSe) {
    return Container(
      width: sizescreen.width * 0.85,
      child: new TextFormField(
        initialValue: businessSe.servicio,
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
  Widget textFieldDuracion(Size sizescreen,ServiciosNegocio businessSe) {
    return Container(
      width: sizescreen.width * 0.85,
      child: new TextFormField(
        initialValue: businessSe.duracion,
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
  Widget preguntasFrecuentes(Size sizescreen,ServiciosNegocio businessSe) {
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
            //cardNegocio(sizescreen),
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
  
  Future editPreguntas(int index){
     final screenSize = MediaQuery.of(context).size;
    return showDialog(
       context: context,
       builder: (context){
       return SimpleDialog(
         contentPadding: EdgeInsets.symmetric(horizontal: 20),
          titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          title: Row(
            children: [
              Icon(MdiIcons.help),
                SizedBox(width: 10),
                Text("Editar la pregunta frecuente")
            ],
          ),
          children: [
            Form(
               key: _formtext,
                  child:Column(
                    children: [
                      textfielPreguntas(screenSize,index),
                       SizedBox(
                      height: 20,
                       ),
                     textfielRespuest(screenSize,index)
                    ],

                  )),
             SizedBox(height: 20),
             Row(
              
               children: [
                  SizedBox(width: 50),
                 MaterialButton(
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                   color: Colors.lightBlue[100],
                   child: Text("Cancelar"),
                   onPressed: (){
                    Navigator.pop(context);
                 }),
                 SizedBox(width: 20),
                 MaterialButton(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                    color: Colors.lightBlue[100],
                   child: Text("Guardar"),
                   onPressed:(){
                    
                 })
               ],
             ) 
          ],
       );

       });
  }
  Future mostrarPreguntas(int index) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              height: height * 0.12,
              width: width * 0.45,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        datos[index].respuesta,
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
        title: Text(datos[index].descripcion, style: TextStyle(fontSize: 20)),
        actions: [
          TextButton(
            child: Text('Editar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],
      ),
    );
  }
  loop(ServiciosNegocio businessSe)
  {
    if(activar==true)
    {
      for(int i=0;i<businessSe.preguntas.length; i++)
    {
      datos.add(businessSe.preguntas[i]);
    }
     activar=false;
    }
    

  }
  Widget cardListaPreguntas(Size screenSize) {
    if (datos.length != 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: screenSize.height * 0.20,
          alignment: Alignment.center,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: datos.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  InputChip(
                    label: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: SingleChildScrollView(
                        child: Container(
                          child: ListTile(
                            trailing: Icon(MdiIcons.play),
                            title: Text(
                              datos[index].descripcion,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              //mostrarPreguntas(index);
                              //ShowdialogEdit(index: index, datos:datos);
                              editPreguntas(index);
                            },
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                     // print('si funciona ');
                    },
                    onDeleted: () {
                      setState(() {
                        datos.removeAt(index);
                        cardListaPreguntas(screenSize);
                      });
                    },
                    deleteIcon: Icon(
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
    } else {
      return Container(height: 50,);
    }
  }
  // Widget cardNegocio(Size sizescreen) {
  //   return Card(
  //     margin:
  //         new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //     elevation: 4.0,
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             CircleButton(
  //               icon: MdiIcons.read,
  //               iconsize: 20,
  //               colorIcon: Colors.blue[600],
  //               colorBorde: Colors.lightBlue[50],
  //               onPressed: () {
  //                 // ingresarPreguntas();
  //                 // setState(() {
  //                 //   cardListaPreguntas(sizescreen);
  //                 // });
  //               },
  //             ),
  //             CircleButton(
  //               icon: MdiIcons.closeCircleOutline,
  //               iconsize: 20,
  //               colorIcon: Colors.blue[600],
  //               colorBorde: Colors.lightBlue[50],
  //               onPressed: () {
  //                 // controllerText.clear();
  //                 // controllerRespuesta.clear();
  //               },
  //             ),
  //           ],
  //         ),
  //         textfielPreguntas(sizescreen),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         textfielRespuest(sizescreen),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         //buttonregistrar(sizescreen),
  //       ],
  //     ),
  //   );
  // }
   Widget textfielPreguntas(Size sizescreen, int index) {
     controllerPregunta.text=datos[index].descripcion;
    return TextFormField(
      maxLines: 2,
      controller: controllerPregunta,
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

  Widget textfielRespuest(Size sizescreen, int index) {
    controllerRespuesta.text=datos[index].respuesta;
    return TextFormField(
      controller: controllerRespuesta,
      autofocus: false,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLines: 3,
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
  Widget buttonRegistrar(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.95,
      child: Row(
        children: [
          SizedBox(
            width: sizescreen.width * 0.05,
          ),
          Container(
            //width: sizescreen.width * 0.45,
            child: ButtonTheme(
              minWidth: sizescreen.width * 0.35,
              //height: sizescreen.height*0.056,
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    //ingresarservicio();
                  },
                  child: Text("Actualizar"),
                  //onPressed:validarregistrar,
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: sizescreen.width * 0.05,
          ),
          Container(
            //width: sizescreen.width * 0.45,
            child: Center(
              child: ButtonTheme(
                minWidth: sizescreen.width * 0.36,
                //height: sizescreen.height*0.056,
                child: RaisedButton(
                  child: Text("Cancelar"),
                  onPressed: () => {Navigator.of(context).pop(false)},
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
   Widget appMenu(Size _screenSize){
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


class ShowdialogEdit extends StatefulWidget {
  final int index;
  final List<PreguntasServicios> datos;
  final VoidCallback onChanged;
  ShowdialogEdit({Key key, this.index, this.datos, this.onChanged,}) : super(key: key);
  @override
  _ShowdialogEditState createState() => _ShowdialogEditState();
}

class _ShowdialogEditState extends State<ShowdialogEdit> {
 GlobalKey<FormState> _formtext = new GlobalKey<FormState>();
  TextEditingController controllerText = TextEditingController();
  TextEditingController controllerRespuesta = TextEditingController();
 String pregunta, respuesta;
  bool validate(String value) {
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FlatButton(onPressed: (){
     
    }, child: null);
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
}