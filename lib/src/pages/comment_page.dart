import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final provider = new DataProvider();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Image(
            image: AssetImage('assets/title.png'),
            height: _screenSize.height * 0.1,
            fit: BoxFit.fill,
          ),
          centerTitle: false,
        ),
        body: FutureBuilder(
          future: provider.getPublicacionesById(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: publicacion(_screenSize, snapshot),
                  ),
                  comentarios(_screenSize, snapshot),
                  Form(
                    child: envioComentario(_screenSize, snapshot.data, id),
                    key: formKey,
                  ),
                ],
              );
            } else {
              return Container(
                height: _screenSize.height * 0.4,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }

  Widget publicacion(Size _screenSize, AsyncSnapshot snapshot) {
    return CardWidgetPublicaciones(
      publicaciones: snapshot.data,
      id: 0,
      space: false,
    );
  }

  Widget comentarios(Size screenSize, AsyncSnapshot snapshot) {
    final data = snapshot.data[0];
    if (snapshot.hasData) {
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            // elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data.comentarios[i].fotoUser),
              ),
              title: Text(data.comentarios[i].nombre),
              subtitle: Text(data.comentarios[i].comentaryDescription),
              trailing: Text(data.comentarios[i].timeAgo),
            ),
          );
        },
        childCount: data.comentarios.length,
      ));
    } else {
      return SliverToBoxAdapter(
        child: Container(
          height: screenSize.height * 4,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  envioComentario(Size screenSize, data, id) {
    String content;
    final prefs = new PreferenciasUsuario();
    final useremail = prefs.currentCorreo;
    return SliverToBoxAdapter(
      child: Card(
        elevation: 30,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
              height: screenSize.height * 0.1,
              width: screenSize.width * 0.71,
              child: TextFormField(
                onSaved: (newValue) => content = newValue,
                textCapitalization: TextCapitalization.sentences,
                decoration:
                    InputDecoration(labelText: 'Escribe tu comentario...'),
                expands: true,
                maxLines: null,
                minLines: null,
                autocorrect: true,
                autofocus: true,
              ),
            ),
            FlatButton(
                onPressed: () async {
                  formKey.currentState.save();
                  print(content);
                  if(content.length>= 1){
                    await provider.setComentario(content, id, useremail);
                  setState(() {});
                  }
                  
                },
                child: Icon(
                  Icons.send,
                  color: Colors.lightBlue,
                ))
          ],
        ),
      ),
    );
  }
}
