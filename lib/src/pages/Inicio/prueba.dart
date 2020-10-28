import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    List<String> list = new List();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Card(
                elevation: 10,
                child: ListView.builder(
                  itemCount: 1 + list.length,
                  shrinkWrap: true,
                  
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, int id) {
                    if (list.length == 0) {
                      return OutlineButton(
                        onPressed: () {
                          print('vale verga la vida');
                        },
                        child: Icon(Icons.add),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
