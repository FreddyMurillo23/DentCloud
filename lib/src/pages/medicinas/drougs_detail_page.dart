import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/drougs_model.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class DrougsDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    Medicamento medicina = ModalRoute.of(context).settings.arguments;
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
            icon: MdiIcons.pill,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[


        ],),
      ),
    );
  }
}
