//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class RegisterBusiness extends StatefulWidget {
  RegisterBusiness({Key key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  //File imageFile;
  @override
  Widget build(BuildContext context) {
     final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(sizeScreen),
      body: Column(
        children: [
          fotoperfil(sizeScreen),
        ],
      ),

    );
  }

 
 _seleccionarFoto() async {
   // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
 }

Widget fotoperfil(Size sizescreen)
{
  return  Padding(
      padding: EdgeInsets.all(20),
      child: Center(
      child: Stack(
        //fit:  StackFit.expand,
        children: [
          Container(
          width: sizescreen.width*0.3,
            height: sizescreen.height*0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: FadeInImage(
                placeholder: AssetImage('assets/placeholder.png'),
                 image: new NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
              fit: BoxFit.cover
              ),
            ),
            decoration:  BoxDecoration(
              shape: BoxShape.circle, 
            ),
     //color:  Colors.blue,
     
    ),
    Positioned(
         bottom: -11,
         right: -15,
          child: Container(
        child: IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: (){

          },
        ),
      ),
    ),
    ],
      ),
      ),
  );
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