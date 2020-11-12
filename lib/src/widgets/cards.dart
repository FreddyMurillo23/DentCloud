import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/models/statuslike.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/profile_avatar.dart';

class CardWidgetPublicaciones extends StatefulWidget {
  final int id;
  final List<Publicacion> publicaciones;
  final CurrentUsuario userinfo;

  const CardWidgetPublicaciones(
      {Key key, @required this.publicaciones, @required this.id, this.userinfo})
      : super(key: key);

  @override
  _CardWidgetPublicacionesState createState() =>
      _CardWidgetPublicacionesState();
}

class _CardWidgetPublicacionesState extends State<CardWidgetPublicaciones> {
  bool statuslike = false;
  final dataprovider = new DataProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final userDataProfile = new DataProvider();
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            width: _screenSize.width * 0.999,
            // height: _screenSize.height * 0.70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(2.0, 10.0))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    publicacionCard(context, _screenSize, userDataProfile),
                    widget.publicaciones[widget.id].imagenPublicacion == 'empty'
                        ? Divider(
                            height: 0,
                            thickness: 0,
                            color: Colors.transparent,
                          )
                        : Divider(
                            height: 10,
                            thickness: 0,
                            color: Colors.transparent,
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          userAvatar(context),
                          SizedBox(
                            height: 4.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '${widget.publicaciones[widget.id].descripcionPublicacion}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          comentariosYMeGustas(),

                          // publicaciones[id].getImagenPublicacion() != null
                          // ? const SizedBox.shrink()
                          // : const SizedBox(height: 6.0,)
                        ],
                      ),
                    ),
                    bottonCard(_screenSize),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: _screenSize.height * 0.05),
        ],
      ),
    );
  }

  Widget userAvatar(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Row(
        children: <Widget>[
          ProfileAvatar(
            imageUrl:
                widget.publicaciones[widget.id].fotoPerfilUsuarioPublicacion,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.publicaciones[widget.id].usuarioPublicacion,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.publicaciones[widget.id].timeAgo}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
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
          CircleButton(
            icon: Icons.more_horiz,
            iconsize: 25,
            onPressed: () {
              print('options');
            },
            colorBorde: null,
            colorIcon: null,
          ),
        ],
      ),
    );
  }

  Widget publicacionCard(
      BuildContext context, Size _screenSize, userDataProfile) {
    if (widget.publicaciones[widget.id].imagenPublicacion == 'empty') {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        // alignment: Alignment(-0.8, 1),
        child: etiquetasList(context, _screenSize, userDataProfile),
      );
    } else {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 10.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              alignment: Alignment(-0.95, 0.99),
              children: <Widget>[
                GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(
                        widget.publicaciones[widget.id].imagenPublicacion),
                    // image: NetworkImage(publicaciones[index].getImagenPublicacion),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    fadeInDuration: Duration(milliseconds: 200),
                    // height: _screenSize.height * 0.5,
                    width: _screenSize.width * 0.99,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    // !userDataProfile
                    // !    .getPublicacionesByUser(publicaciones[id].correoUsuario)
                    // !    .then((value) {
                    // !  // Navigator.pushNamed(context, 'perfil', arguments: value);
                    // !});
                  },
                ),
                etiquetasList(context, _screenSize, userDataProfile),
              ],
            ),
          ));
    }
  }

  Widget bottonCard(Size screenSize) {
    return Container(
      width: screenSize.height * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          meGustaButton(screenSize),
          SizedBox(
            width: screenSize.width * 0.15,
          ),
          FlatButton(
            child: Row(
              children: [
                Icon(
                  MdiIcons.commentOutline,
                  color: Colors.blue[500],
                  size: screenSize.width * 0.05,
                ),
                Text(
                  ' Comentar',
                  style: TextStyle(fontSize: screenSize.width * 0.038),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget comentariosYMeGustas() {
    return Container(
      // height: 30,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Divider(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('${widget.publicaciones[widget.id].comentariosCount}   ·'),
                SizedBox(
                  width: 10,
                ),
                Text('${widget.publicaciones[widget.id].likesCount}'),
              ],
            ),
            Divider(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget etiquetasList(
      BuildContext context, Size _screenSize, userDataProfile) {
    return Container(
      height: _screenSize.height * 0.06,
      width: _screenSize.width,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + widget.publicaciones[widget.id].etiquetas.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Row(
              children: [
                InputChip(
                    avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          widget.publicaciones[widget.id]
                              .inicialNegocioPublicacion,
                          style: TextStyle(color: Colors.black),
                        )),
                    label: Text(
                      widget.publicaciones[widget.id].negocioPublicacion,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.lightBlue,
                    onPressed: () {
                      print(widget.publicaciones[widget.id].negocioRuc);

                      Navigator.pushNamed(context, 'outBusiness',
                          arguments:
                              widget.publicaciones[widget.id].negocioRuc);
                    }),
                SizedBox(
                  width: 6,
                ),
              ],
            );
          } else {
            final data = widget.publicaciones[widget.id].etiquetas[index - 1];
            return Row(
              children: [
                Container(
                  width: _screenSize.width * 0.38,
                  child: InputChip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            data.inicialUsuario,
                            style: TextStyle(fontSize: 12),
                          )),
                      label: Text(data.nombreUsuarioEtiquetado),
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pushNamed(context, 'outPerfil',
                            arguments: data.correoEtiquetado);
                      }),
                ),
                SizedBox(
                  width: 0,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  meGustaButton(Size screenSize) {
    String correo = prefs.currentCorreo;
    final id = widget.publicaciones[widget.id];
    print(correo);
    print(id.idPublicacion);
    return FutureBuilder(
        future: dataprovider.getLikeStatus(correo, id.idPublicacion),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            statuslike = snapshot.data;
            return FlatButton(
              child: Row(
                children: [
                  statuslike
                      ? Icon(
                          MdiIcons.thumbUp,
                          color: Colors.blue[400],
                          size: screenSize.width * 0.05,
                        )
                      : Icon(
                          MdiIcons.thumbUpOutline,
                          color: Colors.blue[400],
                          size: screenSize.width * 0.05,
                        ),
                  Text(
                    ' Me Gusta',
                    style: TextStyle(fontSize: screenSize.width * 0.038),
                  ),
                ],
              ),
              onPressed: () async{
                await dataprovider.setLikeStatus(correo, id.idPublicacion);
                setState((){
                  
                  // statuslike = !statuslike;
                });
              },
            );
          } else {
            return FlatButton(
              child: Row(
                children: [
                  Icon(
                    MdiIcons.thumbUpOutline,
                    color: Colors.blue[400],
                    size: screenSize.width * 0.05,
                  ),
                  Text(
                    ' Me Gusta',
                    style: TextStyle(fontSize: screenSize.width * 0.038),
                  ),
                ],
              ),
              onPressed: () {},
            );
          }
        });
  }
}
