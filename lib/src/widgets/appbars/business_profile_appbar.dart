import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import '../circle_button.dart';
// import 'package:flutter/material.dart';

class BusinessAppBar extends StatefulWidget {
  final NegocioData userinfo;
  final CurrentUsuario usuario;
  BusinessAppBar({Key key, @required this.userinfo, this.usuario})
      : super(key: key);

  @override
  _BusinessAppBarState createState() => _BusinessAppBarState();
}

class _BusinessAppBarState extends State<BusinessAppBar> {
  List normal = new List();
  bool current = true;
  //*true = currentLoginProfile
  //!false = OutProfile

  cargarDatos() {
    normal.add(widget.userinfo.ruc);
    normal.add(widget.usuario);
  }

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
      // elevation: 2.0,
      expandedHeight: _screenSize.height * 0.55,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      centerTitle: true,
      floating: false,
      pinned: true,
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.blueGrey.shade100,
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        // width: _screenSize.width * 1,
        height: _screenSize.height * 0.045,
        // color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
          child: Text(
            '   ${widget.userinfo.negocio}   ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
            overflow: TextOverflow.ellipsis,
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
              centerTitle: true,
              titlePadding: EdgeInsets.fromLTRB(10, 50, 100, 5),
              background: Container(
                  child: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: AssetImage('assets/fondo.jpg'),
                    fit: BoxFit.cover,
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
          top: screensize.height * 0.050,
          left: screensize.width * 0.04,
          right: screensize.width * 0.04,
          bottom: 10),
      child: Center(
        child: Column(
          children: [
            businessData(screensize, context),
            profileButton(),

            // widget.userinfo.tipoUsuario == 'D' ? profileButton() : Container()
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screensize.height * 0.065,
          horizontal: screensize.width * 0.04),
      child: Column(
        children: [
          Container(
            height: screensize.height * 0.2,
            width: screensize.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(width: 5, color: Colors.blueGrey.shade100),
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
          businessData(screensize, context),
          profileButton(),
        ],
      ),
    );
  }
  Widget profileButton() {
    return current
        ? editarPerfil()
        : AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchOutCurve: Curves.easeOutExpo,
            switchInCurve: Curves.easeInExpo,
            child: follow ? seguir() : seguido(),
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
    final prefs = new PreferenciasUsuario();
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
              colors: [Color(0xFF81D4FA), Color(0xFF29B6F6), Color(0xFF039BE5)])
          .createShader(rect),
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'settings',arguments: prefs.profileID);
          setState(() {});
        },
        child: Text('Editar Consultorio'),
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

  Widget listContent(Size screensize) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        // height: screensize.height * 0.30,
        width: screensize.width * 0.36,
        color: Colors.transparent,
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            itemCount: widget.userinfo.openServicios.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.userinfo.openServicios.length == 0) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        // height: screensize.height * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: Colors.white,
                          border: Border.all(
                              width: screensize.width * 0.01,
                              color: Colors.blueGrey.shade100),
                        ),
                        child: ClipRRect(
                          child: FadeInImage(
                            image: AssetImage('assets/logo.png'),
                            placeholder: AssetImage('assets/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      Text('No hay recientes')
                    ],
                  ),
                );
              } else {
                print(widget.userinfo.openServicios[index].servicio);

                return Container(
                  child: Column(
                    children: [
                      Container(
                        height: screensize.height * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: Colors.white,
                          border: Border.all(
                              width: screensize.width * 0.01,
                              color: Colors.blueGrey.shade100),
                        ),
                        child: ClipRRect(
                          child: FadeInImage(
                            image: NetworkImage(widget
                                .userinfo.openServicios[index].imagenServicio),
                            placeholder: AssetImage('assets/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      Text('${widget.userinfo.openServicios[index].servicio}',
                          textAlign: TextAlign.center)
                    ],
                  ),
                );
              }
            }),
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
          // width: screensize.width * 0.38,
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
}
