import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/search/search_user_business.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/create_post_container.dart';
// import 'package:muro_dentcloud/src/providers/menu_providers.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomePage extends StatefulWidget {
  final CurrentUsuario currentuser;
  const HomePage({Key key, @required this.currentuser}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isvisible=true;
  bool darkMode=false;
  bool swichValue=false;
  StreamSubscription _streamSubscription;
  Location _tracker=Location();
  Marker marker;
  Circle circle;
  GoogleMapController controlador;

  final LatLng fromPoint=LatLng(-0.336994,-78.543437);
  CameraPosition _initialPosition=CameraPosition(target: LatLng(-0.336994,-78.543437), zoom: 16 );
  Completer<GoogleMapController> _controller=Completer();


  // transformacion de json a string 
  changeMapMode(){
    setState(() {
      if(darkMode==true)
      {
        getJsonFile("assets/json_googlemap/light.json").then(setMapStyle);
      }
      else
      {
        getJsonFile("assets/json_googlemap/dark.json").then(setMapStyle);
      }
    });
  }

  Future<String> getJsonFile(String path) async {
  return await rootBundle.loadString(path);
}

void setMapStyle(String mapStyle){
  controlador.setMapStyle(mapStyle);
}
 

  void _onMapCreated(GoogleMapController controller){
    //_controller.complete(controller);
    controlador=controller;
    //centerView();
  }


  centerView() async {
    await controlador.getVisibleRegion();
  }
  @override
  Widget build(BuildContext context) {
    final sizecreen= MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    return Scaffold(      
      body: bodyMap(sizecreen), 
      //Center(child: Image(image: AssetImage('assets/1200px-SITIO-EN-CONSTRUCCION.jpg'),)),
    );
  }

  Widget bodyMap(Size sizecreen){
  
  return Stack(
    children: [
      GoogleMap(initialCameraPosition: _initialPosition,
      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,
      ),
      Visibility(
        visible: true,
        child: Container(
          margin: EdgeInsets.only(top: 0,left: 50),
          alignment: Alignment.centerLeft,
          color: Color(0xFF808080).withOpacity(0.5),
          height: sizecreen.height*0.07,
          width: sizecreen.width*0.8,
          child: Row(
             children: [
               SizedBox(width: 10,),
               Switch(
                 activeColor: Colors.black87,
                 onChanged: (newValue){
                  setState(() {
                   this.darkMode=newValue;
                  });
                 }, value: darkMode,
               ),
               SizedBox(width: 10,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FloatingActionButton(
                   child: Icon(Icons.directions_bike),
                   elevation: 5,
                   backgroundColor: Colors.greenAccent,
                   onPressed: (){},
                 ),
                 ),
               SizedBox(width: 10,),
                Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FloatingActionButton(
                   child: Icon(Icons.location_on_sharp),
                   elevation: 5,
                   backgroundColor: Colors.blueAccent,
                   onPressed: (){},
                 ),
                 ),
               SizedBox(width: 10,),
                Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FloatingActionButton(
                   child: Icon(Icons.local_taxi_outlined),
                   elevation: 5,
                   backgroundColor: Colors.blueAccent,
                   onPressed: (){},
                 ),
                ),
             ],
          ),
        ),
      ),
    ],
  );
  }

  // Widget body(){
  //   return GoogleMap(onMapCreated: _onMapCreated,
  //   initialCameraPosition: _initialPosition,
  //   //markers: createMarkers(),
     
  //   );
  // }
  Set<Marker> createMarkers(){
    var tmp=Set<Marker>();

    tmp.add(Marker(
      markerId: MarkerId('MyPosition'),
      position: fromPoint,
      infoWindow: InfoWindow(title: "My Location")
    ));
    return tmp;
  }


  // Widget listaPerfiles(CurrentUsuario userinfo, PreferenciasUsuario prefs) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: 1 + widget.currentuser.openUserTrabajos.length,
  //       itemBuilder: (context, int index) {
  //         // print('${widget.currentuser.openUserTrabajos}');
  //         final data = widget.currentuser.openUserTrabajos;
  //         if (widget.currentuser.openUserTrabajos.length == 0) {
  //           return Column(
  //             children: [
  //               ListTile(
  //                 title: Text(
  //                     '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
  //                 subtitle: Text(
  //                     '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
  //                 trailing: Icon(Icons.business),
  //                 onTap: () {
  //                   prefs.currentProfile = true;
  //                   print(userinfo.correo);
  //                   prefs.profileID = userinfo.correo;
  //                   prefs.profileName =
  //                       '${userinfo.nombres} ${userinfo.apellidos}';
  //                   print('Tap in that sheet');
  //                 },
  //               ),
  //               Divider(
  //                 color: Colors.grey,
  //               )
  //             ],
  //           );
  //         } else if (index == 0) {
  //           return Column(
  //             children: [
  //               ListTile(
  //                 title: Text(
  //                     '${widget.currentuser.nombres} ${widget.currentuser.apellidos}'),
  //                 subtitle: Text(
  //                     '${widget.currentuser.correo} \n${widget.currentuser.cedula}'),
  //                 trailing: Icon(Icons.person),
  //                 onTap: () {
  //                   print(userinfo.correo);
  //                   prefs.currentProfile = true;
  //                   prefs.profileID = userinfo.correo;
  //                   prefs.profileName =
  //                       '${userinfo.nombres} ${userinfo.apellidos}';
  //                   Navigator.of(context).pushNamedAndRemoveUntil(
  //                       '/', (Route<dynamic> route) => false);
  //                   print('Im that bitch');
  //                 },
  //               ),
  //               Divider(
  //                 color: Colors.grey,
  //               )
  //             ],
  //           );
  //         } else {
  //           return Column(
  //             children: [
  //               ListTile(
  //                 title: Text(data[index - 1].nombreNegocio),
  //                 subtitle: Text(
  //                     '${data[index - 1].idNegocio} \n${data[index - 1].rolDoctor}'),
  //                 trailing: Icon(Icons.business),
  //                 onTap: () {
  //                   print('Last Hore');
  //                   prefs.currentProfile = false;
  //                   prefs.profileID = data[index - 1].idNegocio;
  //                   prefs.profileName = data[index - 1].nombreNegocio;
  //                   Navigator.of(context).pushNamedAndRemoveUntil(
  //                       '/', (Route<dynamic> route) => false);
  //                 },
  //               ),
  //               Divider(
  //                 color: Colors.grey,
  //               )
  //             ],
  //           );
  //         }
  //       });
  // }
}
