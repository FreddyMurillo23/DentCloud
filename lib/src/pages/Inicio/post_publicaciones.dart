// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/follows_model.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/search/search_follows.dart';
import 'package:muro_dentcloud/src/search/search_follows_business.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

// import 'package:muro_dentcloud/src/widgets/circle_button.dart';
// import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
class PostPublicaciones extends StatefulWidget {
  final CurrentUsuario currentuser;
  final Publicacion publicacion;
  const PostPublicaciones(
      {Key key, @required this.currentuser, this.publicacion})
      : super(key: key);
  @override
  _PostPublicacionesState createState() => _PostPublicacionesState();
}

class _PostPublicacionesState extends State<PostPublicaciones> {
  TextEditingController controladorCorreoUser = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final publicacion = new Publicacion();
  List<Etiquetas> etiquetas = new List();

  PreferenciasUsuario prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ingreso Publicacion"),
          content: new Text("Se subio correctamente su publicacion "),
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
  var correo = ' ';
  File foto;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _mostrarImagen(screenSize),
              _crearPost(screenSize),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              _etiquetaNegocio(screenSize),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              _etiquetaUsuarios(screenSize),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              _bottonEnviarForm(screenSize, widget.currentuser),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _crearPost(Size screenSize) {
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
        height: screenSize.height * 0.15,
        child: TextFormField(
          onSaved: (newValue) => publicacion.descripcion = newValue,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: 'Escribe tu historia...'),
          expands: true,
          maxLines: null,
          minLines: null,
          autocorrect: true,
          autofocus: false,
        ),
      ),
    );
  }

  Widget _etiquetaNegocio(Size screenSize) {
    correo = prefs.currentCorreo;
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
                'Etiqueta un negocio ',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            card1(correo),
            SizedBox(
              height: screenSize.height * 0.01,
            )
          ],
        ),
      ),
    );
  }

  Widget _etiquetaUsuarios(Size screenSize) {
    correo = prefs.currentCorreo;
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
                'Etiqueta usuarios ',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            cardusuarioEtiqueta(correo),
            Container(
              height: 10,
              width: 10,
            ),
            listaEtiquetados(screenSize)
          ],
        ),
      ),
    );
  }

  Widget _bottonEnviarForm(Size screenSize, CurrentUsuario userinfo) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.lightBlue,
      textColor: Colors.white,
      label: Text('Publicar'),
      icon: Icon(Icons.publish),
      onPressed: () async {
        formKey.currentState.save();
        publicacion.usuario = '${userinfo.nombres} ${userinfo.apellidos}';
        publicacion.correoUsuario = '${userinfo.correo}';
        String id = await publicacionesProvider.subirImagenPublicacion(
            foto, publicacion);
        print(id);
        if (etiquetas.length > 0) {
          for (var i = 0; i < etiquetas.length; i++) {
            etiquetas[i].publicacionId = id;
            print(etiquetas[i].correoEtiquetado);
            print(etiquetas[i].publicacionId);
            print(etiquetas[i].nombreUsuarioEtiquetado);
          }
          await publicacionesProvider.insertarEtiquetas(etiquetas);
        }
        _showDialog();
        // Navigator.pushNamed(context, 'prueba');
      },
    );
  }

  Widget listaEtiquetas(Size screenSize) {
    return Container();
  }

  Widget card1(String email) {
    String headerData;
    if (publicacion.negocio == " ") {
      headerData = "Seleccione un negocio";
    } else {
      headerData = publicacion.negocio;
    }
    return Card(
        margin:
            new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: ListTile(
            leading: Icon(MdiIcons.bookSearchOutline),
            title: Text(headerData),
            trailing: Icon(MdiIcons.play),
            onTap: () async {
              final negocio = await showSearch(
                  context: context,
                  delegate: FollowsBusinessSearch(email, publicacion));
              setState(() {
                if (negocio != null) {
                  publicacion.negocio = negocio.negocio;
                  publicacion.negocioRuc = negocio.negocioRuc;
                }
              });
            }));
  }

  Widget cardusuarioEtiqueta(String email) {
    final etiq = new Etiquetas();
    String headerData;
    if (etiq.nombreUsuarioEtiquetado == " ") {
      headerData = "Agregar usuario";
    } else {
      headerData = etiq.nombreUsuarioEtiquetado;
    }
    return Card(
        margin:
            new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: ListTile(
            leading: Icon(MdiIcons.bookSearchOutline),
            title: Text(headerData),
            trailing: Icon(MdiIcons.play),
            onTap: () async {
              final usuario = await showSearch(
                  context: context,
                  delegate: FollowsSearch(email, publicacion));
              setState(() {
                if (usuario != null) {
                  etiq.nombreUsuarioEtiquetado = usuario.usuario;
                  etiq.correoEtiquetado = usuario.correoUsuario;
                  for (var otp in etiquetas) {
                    print(otp.nombreUsuarioEtiquetado);
                  }
                  print(etiquetas);
                  etiquetas.add(etiq);
                }

                // .add(etiq);
              });
            }));
  }

  Widget listaEtiquetados(Size screenSize) {
    if (etiquetas.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: screenSize.height * 0.06,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              itemCount: etiquetas.length,
              itemBuilder: (BuildContext context, index) {
                // print(index);
                // print(etiquetas[index].correoEtiquetado);
                return Row(
                  children: [
                    InputChip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person)),
                      label: Text(
                        etiquetas[index].nombreUsuarioEtiquetado,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.lightBlue,
                      onPressed: () {},
                      onDeleted: () {
                        setState(() {
                          etiquetas.removeAt(index);
                        });
                      },
                      deleteIcon: Icon(
                        Icons.highlight_remove,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.02,
                    ),
                  ],
                );
              }),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _mostrarImagen(Size screenSize) {
    if (publicacion.imagenPublicacion != 'empty') {
      return Container();
    } else {
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
    }
    // return Container();
  }

  _ingresarImagen(ImageSource tipo) async {
    foto = await ImagePicker.pickImage(source: tipo);
    if (foto != null) {
      //limpieza
    }

    setState(() {});
  }
}
