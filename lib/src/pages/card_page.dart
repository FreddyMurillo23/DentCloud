import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';

class CardPage extends StatefulWidget {
final CurrentUsuario currentuser;
  const CardPage({Key key, @required this.currentuser}) : super(key: key);
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final publicacionesProvider = new DataProvider();
  ScrollController _scrollController = new ScrollController();
  List<int> _publicaciones = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _agregar10(); //? Esta aqui para inicializar los primeros datos que aparezcan en la pantalla y cada que se llama ejecuta 10 mas
//? Metodo oyente, que toma los datos del Scroll controler para saber si llego al final de la pagina.
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
    _scrollController
        .dispose(); //? Destruye el scroll controler para cuando se salga de la pagina
  }

  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawer(currentuser: widget.currentuser,),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Image(image: AssetImage('assets/title.png'),height: _screenSize.height*0.1 ,fit: BoxFit.fill,),
        centerTitle: false,
        // floa ting: true,
        actions: [
          CircleButton(
            icon: Icons.search,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
          CircleButton(
            icon: MdiIcons.facebookMessenger,
            iconsize: 30.0,
            onPressed: () => print('Messenger'),
          )
        ],
      ),
      body:
      Stack(
            children: <Widget>[
              _cards(_screenSize),
              _crearLoading()],
            )
      // body: Container (
      //   child: Column (
      //     children: <Widget>[
      //       // CreatePostContainer(currentUser: 'me vale verga xd ',),
      //       Stack(
      //       children: <Widget>[
      //         _cards(_screenSize),
      //         _crearLoading()],
      //       )
      //     ]
      //   )
      // ),
    );
  }

  //? Llama a dibujar las cartas y recibe los datos desde el provider
  Widget _cards(_screenSize) {
    //*Llama a el metodo get publicaciones que devuelve una lista donde se ecuentran todos los datos
    return FutureBuilder(
      future: publicacionesProvider.getPublicaciones(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: obtenerPagina1,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                // print(publicacionesProvider.getPublicaciones());
                // print(snapshot.data.length);
                return CardWidgetPublicaciones(
                    publicaciones: snapshot.data, id: index
                );
              },
            ),
          );
        } else {
          return Container(
            height: _screenSize.height * 4,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );

    //
  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration(seconds: 1);
    new Timer(duration, () {
      _publicaciones.clear();
      _ultimoItem++;
      _agregar10();
    });
    return Future.delayed(duration);
  }

//? trae la lista de los datos y controla el setSate principal para el redibujado
  void _agregar10() {
    for (var i = 1; i < 10; i++) {
      _ultimoItem++;
      _publicaciones.add(_ultimoItem);
    }
    setState(() {});
  }

// ? Trae los datos y redibuja.
  Future fetchData() async {
    _isLoading = true;
    setState(() {});
    final duration = new Duration(seconds: 1);
    return new Timer(duration, respuestaHTTP);
  }

// ? Condiciona la respuesta http para que los datos que se traigan tengan animacion y luego agrega 10 mas
  void respuestaHTTP() {
    _isLoading = false;
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
    _agregar10();
  }

//? Si esta cargando nueva data hace la animacion de el circularProgrest indicator
//? Si no solo imprime un container vacio.
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
