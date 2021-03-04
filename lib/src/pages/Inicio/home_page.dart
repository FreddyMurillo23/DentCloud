import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model_gps.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/pages/Inicio/marker_information.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
// import 'package:muro_dentcloud/src/providers/menu_providers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:geocoder/model.dart';
import 'package:geocoder/geocoder.dart';

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
  Position locationactual;
  TextEditingController texto = TextEditingController();
  // StreamSubscription _streamSubscription;
  Location tracker = Location();
  List<Address> addresses;
  bool marcador=false;
  String title,urlimagen,ubicacion,telefono;
  LatLng lating;
  bool busquedanegocio=false,markersbusqueda=false;
  NegocioDataGps busquedaneg;
  List<NegocioDataGps> negociogps;
  var tmp=Set<Marker>();
  Marker marker;
  String ciudad;
  Circle circle;
  GoogleMapController controlador;
  final formkey = new GlobalKey<FormState>();
  final LatLng fromPoint = LatLng(-0.336994, -78.543437);
  CameraPosition _initialPosition =
  CameraPosition(target: LatLng(-1.055747, -80.452173), zoom: 12);
  DataProvider1 businessData1 = new DataProvider1();
  final Set<Polyline> polyline={};
  List<NegocioDataGps> resultadoNegocio2;
  PageController _pageController;
  bool marcadorContainer=false;
  List<LatLng> routerCoords;
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: 'AIzaSyCDn9vfwQb0jtuzYp3ycFXgANvrTbmzwig');
 

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
    _pageController=PageController(initialPage: 1,viewportFraction: 0.8);
    
    
    //centerView();
  }

  centerView() async {
    await controlador.getVisibleRegion();
  }

 
  @override
  Widget build(BuildContext context) {
    
    final prefs = new PreferenciasUsuario();
    return Scaffold(
      body: bodyMap(),
      //Center(child: Image(image: AssetImage('assets/1200px-SITIO-EN-CONSTRUCCION.jpg'),)),
    );
  }

  Widget bodyMap() {
    final sizecreen = MediaQuery.of(context).size;
    return Stack(
      //alignment: Alignment(8.0,8.0),
      children: [
        GoogleMap(
          initialCameraPosition: _initialPosition,
          markers: Set.from(tmp),
          polylines: Set.of((polyline.isNotEmpty)?polyline:[]),
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
            height: 110,
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
                     marcadorContainer=true;
                   }, 
                   colorBorde: Colors.white,
                    colorIcon: Colors.black45),
                    SizedBox(width: 5,),
                //  CircleButton(
                //    icon: MdiIcons.nearMe, 
                //    iconsize: 30, 
                //    onPressed: (){
                //      getsomePoints();
                //    }, 
                //    colorBorde: Colors.white,
                //     colorIcon: Colors.black45),

              ],
            )
          )),
         // Visibility(visible:marcador,child: MarkersInformation(title,lating,urlimagen,ubicacion,telefono),),
           resultadoNegocio2 != null? 
           Positioned(
            top:90,
            child: Visibility(visible: marcadorContainer,child:containerResultado(sizecreen)),
          ):Container(),
      ],
    );
  }


Widget containerResultado(Size sizecreen)
{
  return Container(
   height: 150,
   width: sizecreen.width,
   child: PageView.builder(
      controller: _pageController,
      itemCount: resultadoNegocio2.length,
      itemBuilder: (BuildContext context, int index){
        return _coffeeShopList(index);
      },
    ),
    
  );
}

_coffeeShopList(index)
{
  return AnimatedBuilder(animation: _pageController, 
  builder: (BuildContext context,Widget widget)
  {
    double value=1;
    if(_pageController.position.haveDimensions)
    {
      value=_pageController.page-index;
      value=(1-(value.abs()*0.3)+0.06).clamp(0.0, 1.0);
    }
    return Center(
      child: SizedBox(
        height: Curves.easeInOut.transform(value)*125.0,
        width: Curves.easeInOut.transform(value)*350,
        child: widget,
      ),
    );
    
  },
  child:  InkWell(
    onTap: (){
      moverCamara();
    
    },
    child: Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,vertical: 20.0
            ),
            height: 130.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0,4.0),
                  blurRadius: 10.0
                )
              ]
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0)
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        resultadoNegocio2[index].foto
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(width: 5.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resultadoNegocio2[index].negocio,
                      style: TextStyle(
                        color:Colors.deepOrange,
                        fontSize: 13, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Text(
                         resultadoNegocio2[index].ubicacion,
                         style: TextStyle(
                           color: Colors.greenAccent,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Text(
                       "Telefono:${resultadoNegocio2[index].telefono}",
                       style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600
                      ),
                    ),                    
                  ],
                )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    ),
  
  );

}

  void obtenernegocio(String ciudad) async{
    markersbusqueda=false;
    Future<List<NegocioDataGps>> resultado=businessData1.negocioGps(ciudad);
    List<NegocioDataGps> resultado2=await resultado;
    resultadoNegocio2=resultado2;
    negociogps=resultado2;

        for(int i=0;i<resultado2.length;i++)
        {
          setState(() {
             tmp.add(
         Marker(
        markerId: MarkerId(resultado2[i].negocio),
        position: LatLng(resultado2[i].latitud,resultado2[i].longitud),
        infoWindow: InfoWindow(title: resultado2[i].negocio),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        onTap: (){
        setState(() {
          // markersbusqueda=true;
          // marcador=!marcador;
          // title=resultado2[i].negocio;
          // lating=LatLng(resultado2[i].latitud,resultado2[i].longitud);
          // urlimagen=resultado2[i].foto;
          // ubicacion=resultado2[i].ubicacion;
          // telefono=resultado2[i].telefono;

        });
        }
         ),
        );
          });
         
        }
  }


 moverCamara()
 {
   controlador.animateCamera(CameraUpdate.newCameraPosition(
     CameraPosition(
       target: LatLng(resultadoNegocio2[_pageController.page.toInt()].latitud, resultadoNegocio2[_pageController.page.toInt()].longitud),
      zoom: 18,
      bearing: 90,
      tilt: 10,
       
       )
   ));


 }
  void getLocation() async{

    final location = await Geolocator().getCurrentPosition();
    locationactual=location;
    LatLng latlng = LatLng(location.latitude, location.longitude);
    setState(() {
      tmp.add(
      Marker(
      markerId: MarkerId('MyPosition'),
      position: latlng,
      infoWindow: InfoWindow(title: "My Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta)
    )
      );
       createMarkers(location);

    });
     
    if (controlador != null) {
      controlador
          .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 90,
              target: LatLng(location.latitude, location.longitude),
              tilt: 10,
              zoom: 18.00)));
    }
   
  }

  void createMarkers(Position local) async {  
    final coordinates = new Coordinates(local.latitude, local.longitude);
    addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    ciudad=first.locality;
    obtenernegocio(ciudad);
  }

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
   int verificar=0;
   busquedanegocio=false;
    for(int i=0;i<negociogps.length;i++)
    {
      if(busqueda.toLowerCase()==negociogps[i].negocio.toLowerCase()||busqueda.toUpperCase()==negociogps[i].negocio.toUpperCase())
      {

          controlador.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 90,
              tilt: 10,
              target: LatLng(
                  negociogps[i].latitud, negociogps[i].longitud),
              //tilt: 0,
              zoom: 16.00)));
          verificar=1;
          busquedanegocio=true;
          busquedaneg=negociogps[i];
          lating=LatLng(negociogps[i].latitud,negociogps[i].longitud);
      }
    }
    if(verificar==0)
    {
       Geolocator().placemarkFromAddress(busqueda).then((value) {
      controlador.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 90,
              tilt: 10,
              target: LatLng(
                  value[0].position.latitude, value[0].position.longitude),
              //tilt: 0,
              zoom: 16.00)));
    });
    }
   
  }

  getsomePoints() async {
    LatLng origen,destino;

    if(busquedanegocio==true|| markersbusqueda==true)
    {
     origen=LatLng(locationactual.latitude,locationactual.longitude);
     destino=LatLng(lating.latitude,lating.longitude);
      routerCoords=await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(-1.0462,-80.4589), 
        destination: LatLng(-1.0506, -80.4584), 
        mode: RouteMode.walking
        //mode: null
        );
    
    if(routerCoords!=null)
    {
      polyline.add(Polyline(
      polylineId: PolylineId("ruta 1"),
      visible:true,
      points: routerCoords,
      width: 4,
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.buttCap
    ));
    }
     busquedanegocio=false;
     markersbusqueda=false;
    }

  }
}



