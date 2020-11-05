import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBusiness extends StatefulWidget {
  RegisterBusiness({Key key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  var foto;
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

Widget fotoperfil(Size sizescreen)
{
  return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Stack(
         children: [
           Container(
             width: sizescreen.width*0.3,
            height: sizescreen.height*0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: FadeInImage(
                 placeholder: AssetImage('assets/jar-loading.gif'),
                 image: new NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
              fit: BoxFit.cover
              ),
            ),
             decoration:  BoxDecoration(
              shape: BoxShape.circle, 
            ),
           ),
           Positioned(
              bottom: -11,
              right: -15,
               child: Container(
                 child: IconButton(
                 icon: Icon(Icons.add_a_photo),
                 onPressed: (){
                   _selecionarfoto();
                 },
                 ),
            ),
          ),
         ],

        ),


      ),
    );

}

<<<<<<< HEAD
Future  _selecionarfoto() async {
  var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
  this.setState(() {
    foto=picture;
  });
}


=======
>>>>>>> 97e8dc0fa668f083cb9985def58f8a93a93ee73b
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