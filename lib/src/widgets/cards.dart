import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';

class CardWidgetPublicaciones extends StatelessWidget {
  final int id;
  final List<Publicacion> publicaciones;
  const CardWidgetPublicaciones(
      {Key key, @required this.publicaciones, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            width: _screenSize.width * 0.999,
            height: _screenSize.height * 0.70,
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
                    publicacionCard(context, _screenSize),
                    Divider(
                      height: 20,
                      thickness: 0,
                      color: Colors.transparent,
                    ),
                    userAvatar(context),
                    bottonCard(),
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
    return ListTile(
      leading: GestureDetector(
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(
                publicaciones[id].getFotoPerfilUsuarioPublicacion()),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'perfil', arguments: 'UserData');
          }
      ),
      title: Text(publicaciones[id].getUsuarioPublicacion()),
      subtitle: Text(publicaciones[id].getDescripcionPublicacion()),
      onTap: () {
      Navigator.pushNamed(context, 'perfil', arguments: 'Publicacion');
      },
    );
  }

  Widget publicacionCard(BuildContext context, _screenSize) {
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
                  image: NetworkImage(publicaciones[id].getImagenPublicacion()),
                  // image: NetworkImage(publicaciones[index].getImagenPublicacion),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  fadeInDuration: Duration(milliseconds: 200),
                  height: _screenSize.height * 0.5,
                  width: _screenSize.width * 0.99,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'perfil',
                      arguments: 'detalles de la publicacion');
                },
              ),
              InputChip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                          publicaciones[id].getInicialNegocioPublicacion())),
                  label: Text(publicaciones[id].getNegocioPublicacion()),
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'perfil',
                        arguments: 'tu mama');
                  }),
            ],
          ),
        ));
  }

  Widget bottonCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: [
              Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.blue[400],
                size: 20.00,
              ),
              Text(' Me Gusta'),
            ],
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Row(
            children: [
              Icon(
                MdiIcons.commentOutline,
                color: Colors.blue[500],
                size: 20.00,
              ),
              Text(' Comentar'),
            ],
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Row(
            children: [
              Icon(
                MdiIcons.shareOutline,
                color: Colors.blue[300],
                size: 30.00,
              ),
              Text('Compartir'),
            ],
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
