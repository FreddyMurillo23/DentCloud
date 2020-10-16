import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';

class BusinessServicesWg extends StatelessWidget {
  final List<NegocioDato> businessSe;

  const BusinessServicesWg(this.businessSe);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.businessSe[0].servicios.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(this.businessSe[0].servicios[index].servicio),
            subtitle: Text(this.businessSe[0].servicios[index].idServicio),
            trailing: FlatButton(
              onPressed: () {
                //Navigator.pushNamed(context, 'list');
              },
              child: Text(
                'Seguir',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurpleAccent[200],
            ),
            onTap: () {
              //Navigator.pushNamed(context, 'patients');
            },
          );
        });
  }
}
