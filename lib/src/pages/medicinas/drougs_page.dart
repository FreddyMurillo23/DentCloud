import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class DrougsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Image(
          image: AssetImage('assets/title.png'),
          height: _screenSize.height * 0.1,
          fit: BoxFit.fill,
        ),
        centerTitle: false,
        // floa ting: true,
        actions: [
          CircleButton(
            icon: MdiIcons.accountSearchOutline,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
          CircleButton(
            icon: MdiIcons.chatOutline,
            iconsize: 30.0,
            onPressed: () => Navigator.pushNamed(
              context,
              'messenger',
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: _screenSize.height,
          width: _screenSize.width,
          child: Image(
            image: AssetImage('assets/Medical.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
