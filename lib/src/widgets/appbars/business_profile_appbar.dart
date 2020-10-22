import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import '../circle_button.dart';
// import 'package:flutter/material.dart';

class BusinessAppBar extends StatefulWidget {
  final NegocioData userinfo;
  BusinessAppBar({Key key, @required this.userinfo}) : super(key: key);

  @override
  _BusinessAppBarState createState() => _BusinessAppBarState();
}

class _BusinessAppBarState extends State<BusinessAppBar> {
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
      backgroundColor: Colors.indigoAccent,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.fromLTRB(10, 50, 100, 5),
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.blueGrey.shade100),
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white),
          // width: _screenSize.width * 1,
          height: _screenSize.height * 0.035,
          // color: Colors.white,
          child: ClipRRect(
            child: Text(
              '   ${widget.userinfo.openNegocio}   ',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
        ),
        background: Container(
            child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage('assets/fondo.jpg'),
              fit: BoxFit.cover,
            ),
            Row(
              children: <Widget>[
                section1(_screenSize, context),
                section2(_screenSize, context),
              ],
            )
          ],
        )
            //
            ),
      ),
      centerTitle: false,
      floating: false,
      actions: [
        CircleButton(
          icon: MdiIcons.facebookMessenger,
          iconsize: 30.0,
          onPressed: () => print('Messenger'),
        )
      ],
    );
  }

  Widget section1(Size screensize, context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screensize.height * 0.089,
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
          profileButton(),
        ],
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
          child: GestureDetector(
            child: Column(
              children: [
                tilelist(),
                Divider(
                  height: 3,
                  color: Colors.grey,
                  thickness: 10,
                ),
                listContent(screensize),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, 'serviciosNegocios',
                            arguments: widget.userinfo.ruc);
            },
          ),
        ));
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
                      Text('${widget.userinfo.openServicios[index].servicio}')
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
