import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersInformation extends StatefulWidget {
  String title;
  LatLng latLng;
  String urlimagen;
  MarkersInformation(this.title,this.latLng,this.urlimagen);
  @override
  _MarkersInformationState createState() => _MarkersInformationState();
}

class _MarkersInformationState extends State<MarkersInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 50,
            height: 50,
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
                  style: TextStyle(color: Colors.greenAccent),
                ),
                Text(
                  "Latitud: ${widget.latLng.latitude}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "Longitud: ${widget.latLng.latitude}",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

          ),
        ],
      ),
      
    );
  }
}