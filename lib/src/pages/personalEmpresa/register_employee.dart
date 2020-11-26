import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';

class RegisterEmployee extends StatefulWidget {
  RegisterEmployee({Key key}) : super(key: key);

  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
     final NegocioData businessinfo = ModalRoute.of(context).settings.arguments;
     
    return Scaffold(
       
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