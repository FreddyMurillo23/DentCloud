// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';

// import 'package:muro_dentcloud/src/widgets/circle_button.dart';
// import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
class PostPublicaciones extends StatefulWidget {
  final CurrentUsuario currentuser;
  const PostPublicaciones({Key key, @required this.currentuser})
      : super(key: key);
  @override
  _PostPublicacionesState createState() => _PostPublicacionesState();
}

class _PostPublicacionesState extends State<PostPublicaciones> {
  TextEditingController controladorCorreoUser = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Publicacion publicacion = new Publicacion();
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  var correo = ' ';
  bool status = false;
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
              _bottonEnviarForm(screenSize),
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
          autofocus: true,
        ),
      ),
    );
  }

  Widget _etiquetaNegocio(Size screenSize) {
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
            CardExpansionPanel(
              headerData: publicacion.negocio == ' '
                  ? 'Seleccione un Negocio'
                  : publicacion
                      .negocio, //('${widget.currentuser.openUserTrabajos.length}00'),
              icon: Icons.business,
              iconColor: Colors.blueGrey,
              lista: listaPerfiles(
                widget.currentuser,
              ),
              status: status,
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            )
          ],
        ),
      ),
    );
  }

  Widget _etiquetaUsuarios(Size screenSize) {
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
            listaEtiquetas(screenSize),
            Container(
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottonEnviarForm(Size screenSize) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.lightBlue,
      textColor: Colors.white,
      label: Text('Publicar'),
      icon: Icon(Icons.publish),
      onPressed: () {
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

  Widget listaPerfiles(CurrentUsuario userinfo) {
    correo = prefs.currentCorreo;
    // print(userinfo.nombres);
    return FutureBuilder(
        future: publicacionesProvider.getPublicaciones(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: 1 + widget.currentuser.openUserTrabajos.length,
              itemBuilder: (context, int index) {
                // print('${widget.currentuser.openUserTrabajos}');
                final data = widget.currentuser.openUserTrabajos;
                if (widget.currentuser.openUserTrabajos.length == 0) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                            '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                        subtitle: Text(
                            '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                        trailing: Icon(Icons.business),
                        onTap: () {
                          setState(() {
                            publicacion.negocio = 'publicacion';
                            print('setState!!!!! >:3');
                            status = !status;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                } else if (index == 0) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                            '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
                        subtitle: Text(
                            '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
                        trailing: Icon(Icons.person),
                        onTap: () {
                          setState(() {
                            publicacion.negocio = 'publicacion';
                            print('setState!!!!! >:3');
                            status = !status;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(data[index - 1].nombreNegocio),
                        subtitle: Text(
                            '${data[index - 1].idNegocio} \n${data[index - 1].rolDoctor}'),
                        trailing: Icon(Icons.business),
                        onTap: () {
                          setState(() {
                            publicacion.negocio = data[index - 1].nombreNegocio;
                            print('setState!!!!! >:3');
                            print(status);
                            status = !status;
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                }
              });
        });
  }
}
