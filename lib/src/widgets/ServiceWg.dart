import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';

class ServiceDataWg extends StatefulWidget {
  final List<Servicio> businessServices;
  const ServiceDataWg(this.businessServices);

  @override
  _ServiceDataWgState createState() => _ServiceDataWgState();
}

class _ServiceDataWgState extends State<ServiceDataWg> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.businessServices.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                cardListServices('descripcion',
                    this.widget.businessServices[index].descripcion),
                cardListServices(
                    'duracion', this.widget.businessServices[index].duracion),
                cardListServices(
                    'costo', this.widget.businessServices[index].costo),
              ],
            ),
          );
        });
  }

  Widget cardListServices(String headerData, String valueData) {
    return Card(
      margin:
          new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: ExpansionTile(
        title: Container(
          child: Text(
            headerData.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: getIcon('$headerData'),
        children: <Widget>[
          Text(valueData),
        ],
      ),
    );
  }
}
