import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
// import 'package:flutter/material.dart';

class OutBusinessAppBar extends StatefulWidget {
  final NegocioData userinfo;
  OutBusinessAppBar({Key key, @required this.userinfo}) : super(key: key);

  @override
  _OutBusinessAppBarState createState() => _OutBusinessAppBarState();
}

class _OutBusinessAppBarState extends State<OutBusinessAppBar> {
  final p = DataProvider();
  final prefs = PreferenciasUsuario();
  bool current = true;
  //*true = currentLoginProfile
  //!false = OutProfile

  bool follow = true;
  //*true = U allready follow that profile
  //!false = u dont follow that profile

  bool profileType = true;
  //*true = CORREO
  //!false = RUC
  @override
  Widget build(BuildContext context) {
    // final NegocioData userinfo = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: _screenSize.height * 0.55,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      pinned: true,
      centerTitle: true,
      floating: true,
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.blueGrey.shade100),
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white),
        // width: _screenSize.width * 1,
        height: _screenSize.height * 0.045,
        // color: Colors.white,
        child: ClipRRect(
          child: Text(
            '   ${widget.userinfo.openNegocio}   ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
        ),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    // color: Colors.grey[500],
                    color: Colors.lightBlue,
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
            child: FlexibleSpaceBar(
              // centerTitle: true,
              // titlePadding: EdgeInsets.fromLTRB(10, 50, 100, 5),
              background: Container(
                  child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Image(
                      image: AssetImage('assets/fondo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  section1(_screenSize, context)
                ],
              )
                  //
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget section1(Size screensize, context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screensize.height * 0.078,
        left:screensize.width * 0.04 ,
        right: screensize.width * 0.04,
          ),
      child: Column(
        children: [
          businessData(screensize, context),
          profileButton(),
        ],
      ),
    );
  }

  businessData(Size screensize, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          // height: screensize.height*0.15,
          // width: screensize.width * 0.42,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: screensize.height * 0.2,
                  width: screensize.width * 0.4,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 5, color: Colors.lightBlue.shade300),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    child: FadeInImage(
                      image: NetworkImage(widget.userinfo.foto),
                      placeholder: AssetImage('assets/loading.gif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                SizedBox(
                  height: screensize.height * 0.015,
                ),
                Text('Ciudad:'),
                Text(
                  '${widget.userinfo.provincia}, ${widget.userinfo.canton}\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Text('Direccion:'),
                Text(
                  '${widget.userinfo.ubicacion}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget section2(Size screensize, context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.white,
            border: Border.all(
                width: screensize.width * 0.01,
                color: Colors.blueGrey.shade100),
          ),
          child: Column(
            children: [
              tilelist(),
              Divider(
                height: 3,
                color: Colors.grey,
                thickness: 10,
              ),
              // listContent(screensize),
            ],
          ),
        ));
  }

  Widget profileButton() {
    return  
      FutureBuilder(
          future: p.isFollowingBusiness(prefs.currentCorreo, widget.userinfo.ruc),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              follow = snapshot.data;
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                switchOutCurve: Curves.easeOutExpo,
                switchInCurve: Curves.easeInExpo,
                child: follow ? seguido() : seguir(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        );
    // return editarPerfil();
  }

  Widget seguir() {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
              colors: [Color(0xFF81D4FA), Color(0xFF29B6F6), Color(0xFF039BE5)])
          .createShader(rect),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            follow = !follow;
          });
        },
        child: Text('Seguir'),
      ),
    );
  }

  Widget seguido() {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
              colors: [Color(0xFF81D4FA), Color(0xFF29B6F6), Color(0xFF039BE5)])
          .createShader(rect),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            follow = !follow;
          });
        },
        child: Text('Seguido'),
      ),
    );
  }

  Widget editarPerfil() {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
              colors: [Color(0xFF81D4FA), Color(0xFF29B6F6), Color(0xFF039BE5)])
          .createShader(rect),
      child: RaisedButton(
        onPressed: () {
          setState(() {});
        },
        child: Text('Editar Perfil'),
      ),
    );
  }

  Widget tilelist() {
    return Text(
      'Servicios',
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.lightBlue, fontSize: 18),
    );
  }
}
