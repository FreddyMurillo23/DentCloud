import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/providers/publicaciones_provider.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  ScrollController _scrollController = new ScrollController();
  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _agregar10();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _agregar10();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DENT CLOUD'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: SvgPicture.asset("assets/icons/019-left-align-2.svg"),
            onPressed: () {}),
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/011-paper-plane.png"),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[_cards(), _crearLoading()],
      ),
    );
  }

  Widget _cards() {
    final publicacionesProvider = new PublicacionesProvider();
    publicacionesProvider.getPublicaciones();

    return ListView.builder(
      controller: _scrollController,
      itemCount: _listaNumeros.length,
      itemBuilder: (BuildContext context, int index) {
        final imagen = _listaNumeros[index];
        return _cardComplete(imagen);
        // FadeInImage(
        //   image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
        //   placeholder: AssetImage('assets/jar-loading.gif'),
        // );
      },
    );
  }

  Widget _cardComplete(int imagen) {
    return Container(
      child: Column(
        children: <Widget>[
          _cardTipo2(imagen),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _cardTipo2(int imagen) {
    final card = Container(
      // clipBehavior: Clip.antiAlias,
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
                            backgroundColor: Colors.black, child: Text('AB')),
                        label: Text('Aaron Burr'),
                        backgroundColor: Colors.grey[400],
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
    );

    return Container(
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
        child: Column(children: <Widget>[
          card,
        ]),
      ),
    );
  }

  void _agregar10() {
    for (var i = 1; i < 10; i++) {
      _ultimoItem++;
      if(_ultimoItem==97) _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {});
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {});
    final duration = new Duration(seconds: 1);
    return new Timer(duration, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isLoading = false;
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
    _agregar10();
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }
}
