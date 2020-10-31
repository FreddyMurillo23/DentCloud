
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/search/search_drogs.dart';
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
            icon: MdiIcons.pill,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: _screenSize.height,
          width: _screenSize.width,
          child: Stack(
            alignment: Alignment(0, -0.9),
            children: <Widget>[
              Image(height: _screenSize.height,
              width: _screenSize.width,
              image: AssetImage('assets/Medical.gif'),
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(height: _screenSize.height*0.12,),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(2.0, 10.0))
                  ]),
                  width: _screenSize.width*0.9,
                  // color: Colors.white,
                  child: ListTile(
                      leading: Icon(MdiIcons.bookSearchOutline),
                      title: Text('Buscar mediciamento'),
                      trailing: Icon(MdiIcons.play),
                      onTap:() => showSearch(context: context, delegate:DrogSearch()),
                    ),
                ),
                SizedBox(height: _screenSize.height*0.1,),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(2.0, 10.0))
                  ]),
                  width: _screenSize.width*0.9,
                  // color: Colors.white,
                  child: ListTile(
                      leading: Icon(MdiIcons.pencil),
                      title: Text('Editar medicamento'),
                      trailing: Icon(MdiIcons.play),
                      onTap:(){},
                    ),
                ),
                SizedBox(height: _screenSize.height*0.1,),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(2.0, 10.0))
                  ]),
                  width: _screenSize.width*0.9,
                  // color: Colors.white,
                  child: ListTile(
                      leading: Icon(MdiIcons.bookPlusMultiple),
                      title: Text('Agregar medicamento'),
                      trailing: Icon(MdiIcons.play),
                      onTap:(){},
                    ),
                ),
                SizedBox(height: _screenSize.height*0.1,),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(2.0, 10.0))
                  ]),
                  width: _screenSize.width*0.9,
                  // color: Colors.white,
                  child: ListTile(
                      leading: Icon(MdiIcons.deleteSweepOutline),
                      title: Text('Eliminar medicamento'),
                      trailing: Icon(MdiIcons.play),
                      onTap:(){},
                    ),
                ),
              ],
            ),
            ],
            
          ),
        ),
      ),
    );
  }
}
