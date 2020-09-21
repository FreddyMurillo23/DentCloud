import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardWidgetPublicaciones extends StatelessWidget {
  final int imagen;

  const CardWidgetPublicaciones(
    {Key key,
    @required this.imagen,
    
    }) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[500],
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
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
                            FadeInImage(
                              image: NetworkImage(
                                  'https://picsum.photos/450/450/?image=$imagen'),
                              placeholder: AssetImage('assets/jar-loading.gif'),
                              fadeInDuration: Duration(milliseconds: 200),
                              height: 450.0,
                              fit: BoxFit.cover,
                            ),
                            InputChip(
                                avatar: CircleAvatar(
                                    backgroundColor: Colors.black, child: Text('B')),
                                label: Text('BioDent'),
                                backgroundColor: Colors.transparent,
                                onPressed: () {
                                  print('I am the one thing in life.');
                                }),
                          ],
                        ),
                      )),
                  Divider(
                    height: 20,
                    thickness: 0,
                    color: Colors.transparent,
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album, color: Colors.blue),
                    title: Text('Soy el titulo de esta tarjeta'),
                    subtitle: Text(
                        'Aquí estamos con la descripción de la tajera que quiero que ustedes vean para tener una idea de lo que quiero mostrarles'),
                  ),
                  Row(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
