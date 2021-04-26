import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/route_argument.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
// import 'package:flutter_facebook_responsive_ui/config/palette.dart';
// import 'package:flutter_facebook_responsive_ui/models/models.dart';
// import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

import '../../palette.dart';

class BusinessRooms extends StatelessWidget {
  final CurrentUsuario userinfo;
  final NegocioData businessinfo;
  const BusinessRooms({Key key, this.userinfo, this.businessinfo})
      : super(key: key);

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
                'Medicos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            listadoNegocios(_screenSize),
          ],
        ),
      ),
    );
  }

  Widget listadoNegocios(Size _screenSize) {
    final negociosProvider = new DataProvider();
    return FutureBuilder(
      future: negociosProvider.getPublicaciones(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: _screenSize.height * 0.16,
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 4.0,
              ),
              scrollDirection: Axis.horizontal,
              // itemCount: 1 + onlineUsers.length,
              itemCount: 1 + businessinfo.personal.length,
              itemBuilder: (BuildContext context, int index) {
                // print(userinfo.negociosAsistidos.length);
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    //!!

                    child: _CreateRoomButton(business: businessinfo,ruc: businessinfo.ruc,email: userinfo.correo,),
                  );
                }
                // final User user = onlineUsers[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    child: Container(
                      width: _screenSize.width * 0.18,
                      child: Column(
                        children: [
                          Container(
                            height: _screenSize.height * 0.09,
                            width: _screenSize.width * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: FadeInImage(
                                // radius: _screenSize.width*0.1,
                                image: NetworkImage(
                                    '${businessinfo.personal[index - 1].fotoPerfil}'), //!Aqui va un dato
                                placeholder: AssetImage('assets/loading.gif'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: businessinfo
                                        .personal[index - 1].sexoDoctor ==
                                    'F'
                                ? Text(
                                    'Dra. ${businessinfo.personal[index - 1].nombreDoctor}',
                                    overflow: TextOverflow.ellipsis)
                                : Text(
                                    'Dr.  ${businessinfo.personal[index - 1].nombreDoctor}',
                                    overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'outPerfil',
                          arguments:
                              businessinfo.personal[index - 1].correoDoctor);
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
  final NegocioData business;
  final String ruc;
  final String email;

  const _CreateRoomButton({
    Key key,
    this.business,
    @required this.email,
    @required this.ruc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = DataProvider();
    return FutureBuilder(
      future:
          data.getOwner(ruc: ruc, email: email),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return OutlineButton(
      onPressed: () {
        Navigator.pushNamed(context, 'registerEmploye', arguments: business);
      }, //! aqui va un Navigator
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
              Icons.add_box,
              size: 35.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          Text(
            'Agregar\npersonal',
            textAlign: TextAlign.center,
          ), //! Aqui va un dato
        ],
      ),
    );
          } else {
            return OutlineButton(
      onPressed: () {
        Navigator.pushNamed(context, 'businessDoctorServices',
            arguments: RouteArgument(list: business.personal));
      }, //! aqui va un Navigator
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
              Icons.person_search,
              size: 35.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          Text(
            'Ver\ntodos',
            textAlign: TextAlign.center,
          ), //! Aqui va un dato
        ],
      ),
    );
          }
        } else {
          return Container();
        }
      },
    );
    

    
  }
}
