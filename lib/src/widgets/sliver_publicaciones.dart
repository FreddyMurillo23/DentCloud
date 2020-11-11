import 'package:flutter/material.dart';

class SliverPublicaciones extends StatefulWidget {
  SliverPublicaciones({Key key}) : super(key: key);

  @override
  _SliverPublicacionesState createState() => _SliverPublicacionesState();
}

class _SliverPublicacionesState extends State<SliverPublicaciones> {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
      // builder: ,
      // child: SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (BuildContext context, index){
            
      //     }  
      //   )
      // ),
    );
  }
}
