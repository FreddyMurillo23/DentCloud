import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
// import 'package:flutter_facebook_responsive_ui/config/palette.dart';
// import 'package:flutter_facebook_responsive_ui/models/models.dart';
// import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

import '../../palette.dart';

class Rooms extends StatelessWidget {
  final CurrentUsuario userinfo;
  final NegocioData businessinfo;
  const Rooms({
    Key key,
    this.userinfo,this.businessinfo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    // final bool isDesktop = Responsive.isDesktop(context);
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
        child: Column(
          children: [
            Container(
              alignment: Alignment(-0.80, -0.1),
              child: Text(
                'Negocios Seguidos ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            listadoDoctores(_screenSize),
          ],
        ),
      ),
    );
  }

  Widget listadoDoctores(Size _screenSize) {
    final negociosProvider = new DataProvider();
    return FutureBuilder(
      future: negociosProvider.getPublicaciones(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: _screenSize.height * 0.1,
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 4.0,
              ),
              scrollDirection: Axis.horizontal,
              // itemCount: 1 + onlineUsers.length,
              itemCount: 1 + userinfo.negociosAsistidos.length,
              itemBuilder: (BuildContext context, int index) {
                // print(userinfo.negociosAsistidos.length);
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _CreateRoomButton(),
                  );
                }
                // final User user = onlineUsers[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    child: Container(
                      height: _screenSize.height * 0.01,
                      width: _screenSize.width * 0.165,
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: FadeInImage(
                          // radius: _screenSize.width*0.1,
                          image: NetworkImage(
                              'https://assets.umod.org/images/icons/plugin/5d3c47cfdd068.png'), //!Aqui va un dato
                          placeholder: AssetImage('assets/loading.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      print('Hola Mundo');
                    },
                  ),
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
  }
}

class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () => print('Create Room'), //! aqui va un Navigator
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      borderSide: BorderSide(
        width: 3.0,
        color: Colors.blueAccent[100],
      ),
      textColor: Palette.textColor,
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (rect) => LinearGradient(colors: [
              Color(0xFFCDDC39),
              Color(0xFF4BCB1F),
              Color(0xFF1777F2)
            ]).createShader(rect),
            child: Icon(
              Icons.business_center,
              size: 35.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          Text('Descubrir\nNegocios'), //! Aqui va un dato
        ],
      ),
    );
  }
}
