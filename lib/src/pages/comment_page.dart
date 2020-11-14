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
            if(snapshot.hasData){return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: publicacion(_screenSize, snapshot),
                )
              ],
            );}else{
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

  comentario(Size screenSize, String id) {
    final prefs = PreferenciasUsuario();
    final currentuser = prefs.currentCorreo;
    return FutureBuilder(
        future: provider.getPublicacionesById(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // final data = snapshot.data[0];
          if (snapshot.hasData) {
            final data = snapshot.data[0];
            return SingleChildScrollView(
              child: Column(
                children: [
                  CardWidgetPublicaciones(
                    publicaciones: snapshot.data,
                    id: 0,
                    space: false,
                  ),
                  listadoComentarios(screenSize, snapshot.data),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget listadoComentarios(Size screenSize, data) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: data[0].comentarios.length,
              itemBuilder: (BuildContext context, int i) {
                if (data[0].comentarios.length == 0) {
                  print('valio');
                  return Container();
                } else {
                  return Column(
                    children: [
                      Card(
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        // elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data[0].comentarios[i].fotoUser),
                          ),
                          title: Text(data[0].comentarios[i].nombre),
                          subtitle:
                              Text(data[0].comentarios[i].comentaryDescription),
                          trailing: Text(data[0].comentarios[i].timeAgo),
                        ),
                      ),
                      // Divider(),
                    ],
                  );
                }
              }),
          Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
                  height: screenSize.height * 0.1,
                  width: screenSize.width * 0.71,
                  child: TextFormField(
                    // onSaved: (newValue) => publicacion.descripcion = newValue,
                    textCapitalization: TextCapitalization.sentences,

                    decoration:
                        InputDecoration(labelText: 'Escribe tu historia...'),
                    // expands: true,
                    maxLines: null,
                    minLines: null,
                    autocorrect: true,
                    autofocus: false,
                  ),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.lightBlue,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  publicacionHeader(Size screenSize, AsyncSnapshot snapshot) {
    return SliverAppBar(
      elevation: 2,
      // expandedHeight: screenSize.height * 0.55,
      brightness: Brightness.dark,
      backgroundColor: Colors.indigoAccent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: CardWidgetPublicaciones(
          publicaciones: snapshot.data,
          id: 0,
          space: false,
        ),
      ),
    );
  }

  Widget publicacion(Size _screenSize, AsyncSnapshot snapshot) {
    return CardWidgetPublicaciones(
      publicaciones: snapshot.data,
      id: 0,
      space: false,
    );
  }
}
