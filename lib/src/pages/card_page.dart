import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/providers/publicaciones_provider.dart';

class CardPage extends StatelessWidget {
  @override
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
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cards(),
        ],
      ),
    );
  }

  Widget _cards() {
    final publicacionesProvider = new PublicacionesProvider();
    publicacionesProvider.getPublicaciones();
    return FloatingActionButton(
      onPressed: (){} ,
    );
  }
}
