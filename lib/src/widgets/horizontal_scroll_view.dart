import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
// import 'package:flutter_facebook_responsive_ui/config/palette.dart';
// import 'package:flutter_facebook_responsive_ui/models/models.dart';
// import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

import '../../palette.dart';

class Rooms extends StatefulWidget {
  final CurrentUsuario userinfo;
  final NegocioData businessinfo;
  const Rooms({Key key, this.userinfo, this.businessinfo}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final formkey = new GlobalKey<FormState>();
  List<UserTrabajos> data;
  String businessRuc;
  String selectName;
  loadData(CurrentUsuario userinfo) {
    data = userinfo.userTrabajos;
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    loadData(widget.userinfo);
    final _screenSize = MediaQuery.of(context).size;
    // final bool isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
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
                  'Servicios',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: _screenSize.height*0.01),
              selectBox(_screenSize),
              businessRuc != null
                  ? listadoServicios(_screenSize)
                  : SizedBox(height: _screenSize.height*0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget listadoServicios(Size _screenSize) {
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
              itemCount: 1 + widget.userinfo.userTrabajos.length,
              itemBuilder: (BuildContext context, int index) {
                // print(userinfo.negociosAsistidos.length);
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _CreateRoomButton(
                      userinfo: widget.userinfo,
                    ),
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
                          image: NetworkImage(widget
                              .userinfo
                              .userTrabajos[index - 1]
                              .imagenNegocio), //!Aqui va un dato
                          placeholder: AssetImage('assets/loading.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'outBusiness',
                          arguments: widget
                              .userinfo.userTrabajos[index - 1].idNegocio);
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

  Widget selectBox(Size sizescreen) {
    print(businessRuc);
    return Container(
        //color: Colors.white,
        width: sizescreen.width * 0.95,
        child: Center(
          child: DropdownButtonFormField(
              value: selectName,
              //hint: Text('Seleccione el negocio'),
              style: new TextStyle(
                color: Colors.black,
                //fontSize: 18.0,
              ),

              //value: verificar(datos[0].sexo),
              isExpanded: true,
              items: data.map((list) {
                return DropdownMenuItem(
                  child: Text(list.nombreNegocio),
                  value: list.idNegocio,
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Este campo no puede estar vacío' : null,
              onChanged: (value) {
                setState(() {
                  // this.selectName=value;
                  this.businessRuc = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Seleccione un Consultorio",
                hoverColor: Colors.lightBlue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.lightBlue)),
                prefixIcon: Icon(
                  MdiIcons.stethoscope,
                  color: Colors.lightBlue,
                ),
                filled: true,
                fillColor: Colors.white,
              )),
        ));
  }
}

class _CreateRoomButton extends StatelessWidget {
  final CurrentUsuario userinfo;

  const _CreateRoomButton({Key key, this.userinfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        Navigator.pushNamed(context, 'servicesPages', arguments: userinfo);
      },
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
            'Agregar\nServicios',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
