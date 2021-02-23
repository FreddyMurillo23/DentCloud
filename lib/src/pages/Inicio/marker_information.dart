import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersInformation extends StatefulWidget {
  String title;
  LatLng latLng;
  String urlimagen;
  String ubicacion;
  MarkersInformation(this.title,this.latLng,this.urlimagen,this.ubicacion);
  @override
  _MarkersInformationState createState() => _MarkersInformationState();
}

class _MarkersInformationState extends State<MarkersInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 10, right: 15),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.black87 // cambiar el color 
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 60,
            height: 60,
            child: ClipOval(
              child: FadeInImage.assetNetwork(image: widget.urlimagen, placeholder:'assets/placeholder.png' ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20,color: Colors.greenAccent),
                ),
                SizedBox(height: 10,),
                Text(
                  "Direccion: ${widget.ubicacion}",
                  style: TextStyle(fontSize: 12,color: Colors.greenAccent),
                ),
                // Text(
                //   "Latitud: ${widget.latLng.latitude}",
                //   style: TextStyle(fontSize: 13, color: Colors.grey),
                // ),
                // Text(
                //   "Longitud: ${widget.latLng.longitude}",
                //   style: TextStyle(fontSize: 13, color: Colors.grey),
                // ),
              ],
            ),

          ),
        ],
      ),
      
    );
  }
}