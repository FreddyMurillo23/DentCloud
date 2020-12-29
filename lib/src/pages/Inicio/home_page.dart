import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
  bool isvisible = true;
  bool darkMode = false;
  bool swichValue = false;
  String busqueda;
  TextEditingController texto = TextEditingController();
  // StreamSubscription _streamSubscription;
  Location tracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController controlador;
  final formkey = new GlobalKey<FormState>();
  final LatLng fromPoint = LatLng(-0.336994, -78.543437);
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(-1.055747, -80.452173), zoom: 12);

  Completer<GoogleMapController> _controller = Completer();

  void getLocation() async {
    var location = await tracker.getLocation();
    LatLng latlng = LatLng(location.latitude, location.longitude);
    if (controlador != null) {
      controlador
          .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 100,
              target: LatLng(location.latitude, location.longitude),
              //tilt: 0,
              zoom: 18.00)));
    }
  }

  // transformacion de json a string
  changeMapMode() {
    setState(() {
      if (darkMode == false) {
        getJsonFile("data/light.json").then(setMapStyle);
      } else {
        getJsonFile("data/dark.json").then(setMapStyle);
      }
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    controlador.setMapStyle(mapStyle);
  }

  void _onMapCreated(GoogleMapController controller) {
    //_controller.complete(controller);
    controlador = controller;
    //centerView();
  }

  centerView() async {
    await controlador.getVisibleRegion();
  }

  @override
  Widget build(BuildContext context) {
    final sizecreen = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    // if(darkMode==false)
    // {
    // setState((){
    //   changeMapMode();
    // });
    // }
    return Scaffold(
      body: bodyMap(sizecreen),
      //Center(child: Image(image: AssetImage('assets/1200px-SITIO-EN-CONSTRUCCION.jpg'),)),
    );
  }

  Widget bodyMap(Size sizecreen) {
    return Stack(
      //alignment: Alignment(8.0,8.0),
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: Set.of((marker != null) ? [marker] : []),
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
        ),
        
        Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: TextFormField(
            onFieldSubmitted:(value){

              validartextbusqueda();
               searchandNavigate();
               texto.clear();
            },
            controller: texto,
            //initialValue: hearData,
            //readOnly: true,
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
          labelText: "Buscar direccion",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.black)),
          //prefixIcon: Icon(MdiIcons.city),
          suffixIcon: IconButton(icon: Icon(MdiIcons.searchWeb), onPressed: (){ 
            validartextbusqueda();
            searchandNavigate();
            texto.clear();
            }),
          filled: true,
          fillColor: Colors.white,
            ),
            //maxLines: 2,
            validator: (value) => value.isEmpty
            ? 'Este campo no puede estar vacío'
            : !validate(value)
          ? 'Ingrese un localizacion válido'
          : null,
            onSaved: (value) => busqueda = value,
          ),
        
        ),
            ),
        Positioned(
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(bottom: 0,left: 0),
            alignment: Alignment.centerLeft,
            color: Color(0xFF808080).withOpacity(0.0),
            height: 150,
            width: 70,
            child: Column(
              children: [
                 SizedBox(width: 10,),
                Switch(
                   activeColor: Colors.black87,
                   onChanged: (newValue){
                    setState(() {
                     this.darkMode=newValue;
                     changeMapMode();
                    });
                   }, value: darkMode,
                 ),
                 SizedBox(width: 5,),
                 CircleButton(
                   icon: Icons.location_on_sharp, 
                   iconsize: 30, 
                   onPressed: (){
                     getLocation();
                   }, 
                   colorBorde: Colors.white,
                    colorIcon: Colors.black45),

              ],
            )
          ))
        

      ],
    );
  }

  // Widget body(){
  //   return GoogleMap(onMapCreated: _onMapCreated,
  //   initialCameraPosition: _initialPosition,
  //   //markers: createMarkers(),

  //   );
  // }
  // Set<Marker> createMarkers(){
  //   var tmp=Set<Marker>();

  //   tmp.add(Marker(
  //     markerId: MarkerId('MyPosition'),
  //     position: fromPoint,
  //     infoWindow: InfoWindow(title: "My Location")
  //   ));
  //   return tmp;
  // }

  bool validartextbusqueda() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool validate(String value) {
    Pattern pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    return (!regExp.hasMatch(value)) ? false : true;
  }

  

  searchandNavigate() {
    Geolocator().placemarkFromAddress(busqueda).then((value) {
      controlador.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 100,
              target: LatLng(
                  value[0].position.latitude, value[0].position.longitude),
              //tilt: 0,
              zoom: 16.00)));
    });
  }
}
