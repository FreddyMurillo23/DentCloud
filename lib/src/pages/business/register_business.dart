import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class RegisterBusiness extends StatefulWidget {
  RegisterBusiness({Key key}) : super(key: key);

  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
 
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
  /*return  Container(
    decoration: BoxDecoration(
      gradient:  LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
           Color(0XFF2E5596),
          Color(0XFF16304E),
        ]
      ),
    ),
  height: sizescreen.height*0.10,
  //color:  Colors.blue,
  

  );*/
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