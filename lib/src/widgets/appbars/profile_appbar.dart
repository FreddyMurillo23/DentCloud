import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import '../circle_button.dart';
// import 'package:flutter/material.dart';

class ProfileAppBar extends StatefulWidget {
  final CurrentUsuario userinfo;
  ProfileAppBar({Key key, @required this.userinfo}) : super(key: key);

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
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
    final _screenSize = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: _screenSize.height * 0.55,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      pinned: true,
      centerTitle: true,
      title: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.blueGrey.shade100,),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white),
          // width: _screenSize.width * 1,
          // height: _screenSize.height * 0.045,
          // color: Colors.white,
          child: ClipRRect(
            borderRadius: 
        BorderRadius.vertical(bottom: Radius.circular(80)),
            child: Text(
              widget.userinfo.tipoUsuario == 'D'
                  ? widget.userinfo.sexo == 'F'
                      ? '  Dra. ${widget.userinfo.nombres} ${widget.userinfo.apellidos}  '
                      : '  Dr.  ${widget.userinfo.nombres} ${widget.userinfo.apellidos}  '
                  : '  ${widget.userinfo.nombres} ${widget.userinfo.apellidos}  ',
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
      flexibleSpace: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              // color: Colors.grey[500],
              color: Colors.lightBlue,
              blurRadius: 15.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0))
        ]
      ),
        child: ClipRRect(
          borderRadius: 
          BorderRadius.vertical(bottom: Radius.circular(80)),
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
      // centerTitle: false,
      floating: false,
    );
  }

  Widget section1(Size screensize, context) {
    return Padding(
     padding: EdgeInsets.only(
        top: screensize.height * 0.068,
        left:screensize.width * 0.04 ,
        right: screensize.width * 0.04,
          ),
      child: Center(
        child: Column(
          children: [
            profileData(screensize, context),
            widget.userinfo.tipoUsuario == 'D' ? profileButton() : Container()
          ],
        ),
      ),
    );
  }



  Widget profileButton() {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
              colors: [Color(0xFFEEFF41), Color(0xFFB2FF59), Color(0xFF00E5FF)])
          .createShader(rect),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: RaisedButton(
          onPressed: () {
             Navigator.pushNamed(context, 'registerbusiness',
                    arguments: widget.userinfo);
          },
          child: Text('Crear Consultorio'),
        ),
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
          Navigator.pushNamed(context, 'servicesPages');
          setState(() {});
        },
        child: Text('Gestionar Servicios'),
      ),
    );
  }
    profileData(Size screensize, context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        // width: screensize.width * 0.40,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
              height: screensize.height * 0.2,
              width: screensize.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.lightBlue.shade300),
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
              ),
              child: ClipRRect(
                child: FadeInImage(
                  image: NetworkImage(widget.userinfo.fotoPerfil),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            SizedBox(height: screensize.height*0.015,),
              Text(
                widget.userinfo.tipoUsuario == 'D'
                    ? '${widget.userinfo.profesion}\n\n${widget.userinfo.correo}\n${widget.userinfo.ciudadResidencia}\n${widget.userinfo.celular}'
                    : '${widget.userinfo.correo}\n${widget.userinfo.ciudadResidencia}\n${widget.userinfo.celular}',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

}
