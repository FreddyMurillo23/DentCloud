// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/follows_model.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/search/search_follows.dart';
import 'package:muro_dentcloud/src/search/search_follows_business.dart';

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
  final etiq = new Etiquetas();

  PreferenciasUsuario prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  var correo = ' ';
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
      onPressed: () {
        formKey.currentState.save();
        publicacion.usuario = '${userinfo.nombres} ${userinfo.apellidos}';
        publicacion.correoUsuario = '${userinfo.correo}';
        // publicacion.descripcion = '';
        //! publicacion.archivo = '';
        publicacion.fecha = new DateTime.now();
        Navigator.pushNamed(context, 'prueba');
      },
    );
  }

  Widget _addFoto(Size screenSize) {
    return OutlineButton(
      onPressed: () {
        print('vale verga la vida');
      },
      child: Icon(Icons.add),
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
                publicacion.negocio = negocio.negocio;
                publicacion.negocioRuc = negocio.negocioRuc;
              });
            }));
  }

  Widget cardusuarioEtiqueta(String email) {
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
                etiq.nombreUsuarioEtiquetado = usuario.usuario;
                etiq.correoEtiquetado = usuario.correoUsuario;
                etiquetas.add(etiq);
                // .add(etiq);
              });
            }));
  }

  Widget listaEtiquetados(Size screenSize) {
    if (publicacion.etiquetas.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: publicacion.etiquetas.length,
          itemBuilder: (BuildContext context, index) {
            if (publicacion.etiquetas.length == 0) {
              return Container(
                height: 10,
                width: 20,
                color: Colors.lightBlue,
              );
            } else {
              return Container(
                height: 10,
                width: 10,
                color: Colors.red,
              );
            }
          });
    } else {
      return Container();
    }
  }

  // Widget listaPerfiles(CurrentUsuario userinfo, Size screenSize) {
  //   correo = prefs.currentCorreo;
  //   // print(userinfo.nombres);
  //   return Container(
  //     // height: screenSize.height * 0.45,
  //     child: FutureBuilder(
  //         future: publicacionesProvider.follow(correo),
  //         builder: (BuildContext context, AsyncSnapshot snapshot) {
  //           final data = userinfo.openUserTrabajos;
  //           if (snapshot.hasData) {
  //             final followed = snapshot.data[0].negociosSeguidos;
  //             // print(snapshot.data[0].negociosSeguidos[0].nombreNegocio);
  //             return ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: widget.currentuser.openUserTrabajos.length +
  //                   snapshot.data[0].negociosSeguidos.length,
  //               itemBuilder: (context, index) {
  //                 if (widget.currentuser.openUserTrabajos.length == 0) {
  //                   return Column(
  //                     children: [
  //                       ListTile(
  //                         leading: CircleAvatar(
  //                           backgroundColor: Colors.lightBlue,
  //                           backgroundImage:
  //                               NetworkImage('${followed[index].fotoNegocio}'),
  //                         ),
  //                         title: Text('${followed[index].nombreNegocio}'),
  //                         subtitle: Text('${followed[index].negocioSeguido}'),
  //                         trailing: Icon(Icons.business),
  //                         onTap: () {
  //                           setState(() {
  //                             publicacion.negocioRuc =
  //                                 followed[index].negocioSeguido;
  //                             publicacion.negocio =
  //                                 followed[index].nombreNegocio;
  //                             // publicacion.negocio = snapshot
  //                             //     .data[0].negociosSeguidos[index].nombreNegocio;
  //                             print(followed[index].nombreNegocio);
  //                           });
  //                         },
  //                       ),
  //                       Divider(
  //                         color: Colors.grey,
  //                       )
  //                     ],
  //                   );
  //                 } else {
  //                   if (index < data.length) {
  //                     return Column(
  //                       children: [
  //                         ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundColor: Colors.lightBlue,
  //                             backgroundImage:
  //                                 NetworkImage('${data[index].imagenNegocio}'),
  //                           ),
  //                           title: Text('${data[index].nombreNegocio}'),
  //                           subtitle: Text(
  //                               '${data[index].idNegocio} \n${data[index].rolDoctor}'),
  //                           trailing: Icon(Icons.business),
  //                           onTap: () {
  //                             setState(() {
  //                               publicacion.negocioRuc = data[index].idNegocio;
  //                               publicacion.negocio = data[index].nombreNegocio;
  //                               // publicacion.negocio = snapshot
  //                               //     .data[0].negociosSeguidos[index].nombreNegocio;
  //                               print(data[index].nombreNegocio);
  //                             });
  //                           },
  //                         ),
  //                         Divider(
  //                           color: Colors.grey,
  //                         )
  //                       ],
  //                     );
  //                   } else {
  //                     return Column(
  //                       children: [
  //                         ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundColor: Colors.lightBlue,
  //                             backgroundImage: NetworkImage(
  //                                 '${followed[index - data.length].fotoNegocio}'),
  //                           ),
  //                           title: Text(
  //                               '${followed[index - data.length].nombreNegocio}'),
  //                           subtitle: Text(
  //                               '${followed[index - data.length].negocioSeguido}'),
  //                           trailing: Icon(Icons.business),
  //                           onTap: () {
  //                             setState(() {
  //                               publicacion.negocioRuc =
  //                                   followed[index - data.length]
  //                                       .negocioSeguido;
  //                               publicacion.negocio =
  //                                   followed[index - data.length].nombreNegocio;
  //                               // publicacion.negocio = snapshot
  //                               //     .data[0].negociosSeguidos[index].nombreNegocio;
  //                               print(followed[index - data.length]
  //                                   .nombreNegocio);
  //                             });
  //                           },
  //                         ),
  //                         Divider(
  //                           color: Colors.grey,
  //                         )
  //                       ],
  //                     );
  //                   }
  //                 }
  //               },
  //             );
  //           } else {
  //             // final followed = snapshot.data[0].negociosSeguidos;
  //             // print(snapshot.data[0].negociosSeguidos[0].nombreNegocio);
  //             return ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: widget.currentuser.openUserTrabajos.length,
  //                 itemBuilder: (context, index) {
  //                   if (widget.currentuser.openUserTrabajos.length != 0) {
  //                     return Column(
  //                       children: [
  //                         ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundColor: Colors.lightBlue,
  //                             backgroundImage:
  //                                 NetworkImage('${data[index].imagenNegocio}'),
  //                           ),
  //                           title: Text('${data[index].nombreNegocio}'),
  //                           subtitle: Text(
  //                               '${data[index].idNegocio} \n${data[index].rolDoctor}'),
  //                           trailing: Icon(Icons.business),
  //                           onTap: () {
  //                             setState(() {
  //                               publicacion.negocioRuc = data[index].idNegocio;
  //                               publicacion.negocio = data[index].nombreNegocio;
  //                               // publicacion.negocio = snapshot
  //                               //     .data[0].negociosSeguidos[index].nombreNegocio;
  //                               print(data[index].nombreNegocio);
  //                             });
  //                           },
  //                         ),
  //                         Divider(
  //                           color: Colors.grey,
  //                         )
  //                       ],
  //                     );
  //                   } else {
  //                     return ListTile(
  //                       title: Text(
  //                           'Debes seguir a un Negocio para poder publicar'),
  //                     );
  //                   }
  //                 });
  //           }
  //         }),
  //   );
  // }
}
