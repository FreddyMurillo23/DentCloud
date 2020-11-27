import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_doctor.dart';


class RegisterEmployee extends StatefulWidget {
  RegisterEmployee({Key key}) : super(key: key);


  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
   final formkey = new GlobalKey<FormState>();
   DoctorDato doctor;
   File foto;
  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
     final NegocioData businessinfo = ModalRoute.of(context).settings.arguments;
     
    return Scaffold(
       appBar: appMenu(screenSize),
       body: Container(
          padding: EdgeInsets.all(20),
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Form(
             key: formkey,
             child: Column(
               children: [
                _mostrarImagen(screenSize),
                
               ],
             ),
           ),
         ),
       ),
    );
  }
  
 Widget _mostrarImagen(Size screenSize) {
    if (doctor!= null) {
      return Stack(
        alignment: Alignment(0.95, 0.99),
        children: <Widget>[
          Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
               image: NetworkImage(doctor.fotoPerfil),
               placeholder: AssetImage('assets/placeholder.png'),
              )
                // height: 300.0,
              ),
            ),
          
          
        ],
      );
    }
    return Stack(
      alignment: Alignment(1, 0.99),
      children: <Widget>[
        Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 8.0, bottom: 25.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 30.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/upload.png'))),
        
        // IconButton(
        //     icon: Icon(Icons.add_a_photo),
        //     onPressed: () {
        //       _ingresarImagen();
        //     })
      ],
    );
    // return Container();
  }

  Widget appMenu(Size _screenSize) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,
      actions: <Widget>[
        /*CircleButton(
          icon: MdiIcons.forumOutline,
          iconsize: 30.0,
          onPressed: (){},
          // onPressed: () => Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )*/
      ],
    );
  }
}