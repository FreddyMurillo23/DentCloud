import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/profile_avatar.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  ScrollController scrollController = new ScrollController();
  final provider = new DataProvider();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 1),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
    // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

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
                controller: scrollController,
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              userAvatarComentario(screenSize, snapshot, i),
            ],
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
                autofocus: false,
                keyboardType: TextInputType.text,
              ),
            ),
            FlatButton(
                onPressed: () async {
                  formKey.currentState.save();
                  print(content);
                  if (content.length >= 1) {
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

  Widget userAvatarComentario(Size screenSize, AsyncSnapshot<List<Publicacion>> snapshot, int i) {
    Publicacion data = snapshot.data[0];
    // print(data.comentarios[i].comentaryId);
    final prefs = new PreferenciasUsuario();
    final useremail = prefs.currentCorreo;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // elevation: 5,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ProfileAvatar(
                  imageUrl: data.comentarios[i].fotoUser,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.comentarios[i].nombre}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          '${data.comentarios[i].timeAgo}',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12.0),
                        ),
                        Icon(
                          Icons.public,
                          color: Colors.grey[600],
                          size: 12.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              data.comentarios[i].userEmail == useremail||data.correoUsuario == useremail?
              GestureDetector(
                child: PopupOptionMenu(data, i),
                onTap: () {
                  setState(() {});
                },
              ):Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 1, 12, 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${data.comentarios[i].comentaryDescription}',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuOption { Eliminar, Modificar }

class PopupOptionMenu extends StatefulWidget {
  Publicacion comentario;
  int i;
  PopupOptionMenu(
    this.comentario,
    this.i, {
    Key key,
  }) : super(key: key);

  @override
  _PopupOptionMenuState createState() => _PopupOptionMenuState();
}

class _PopupOptionMenuState extends State<PopupOptionMenu> {
  final provider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        setState(() {
          if (result == MenuOption.Eliminar) {
            eliminar();
            setState(() {});
          }
          if (result == MenuOption.Modificar) {
            modificar();
            setState(() {});
          }
        });
      },
      itemBuilder: (BuildContext context) {
        // final menuotp = new MenuOption();
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
              height: 1,
              child: Container(
                  // height: screenSize.height*0.015,
                  // width: screenSize.width*0.1,
                  child: ListTile(
                title: Text('Eliminar'),
                leading: Icon(Icons.delete),
              )),
              value: MenuOption.Eliminar),
          PopupMenuItem(
              child: Container(
                  // height: screenSize.height*0.015,
                  // width: screenSize.width*0.1,
                  child: ListTile(
                title: Text('Modificar'),
                leading: Icon(Icons.edit),
              )),
              value: MenuOption.Modificar),
        ];
      },
    );
  }

  void eliminar() {
    provider
        .deleteComentario(widget.comentario.comentarios[widget.i].comentaryId);
    print('valeskk');
    print(widget.comentario.comentarios[widget.i].comentaryId);
  }

  void modificar() {
    createAlerDialog(context);
  }

  createAlerDialog(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edite su comentario: '),
            content: TextField(
              controller: controller,
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              MaterialButton(
                elevation: 5.0,
                onPressed: () async {
                  provider.putComentario(controller.text.toString(),
                      widget.comentario.comentarios[widget.i].comentaryId);
                  Navigator.of(context).pop();
                },
                child: Text('Modificar'),
              )
            ],
          );
        });
  }
}
