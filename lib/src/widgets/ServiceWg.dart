import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';

class ServiceDataWg extends StatefulWidget {
  final List<ServiciosNegocio> businessServices;
  const ServiceDataWg(this.businessServices);

  @override
  _ServiceDataWgState createState() => _ServiceDataWgState();
}

class _ServiceDataWgState extends State<ServiceDataWg> {
  List<PreguntasFrecuente> datita = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.6,
      child: ListView.builder(
          itemCount: this.widget.businessServices.length,
          itemBuilder: (BuildContext context, int index) {
            datita = widget.businessServices[index].preguntas;

            return Container(
              child: Column(
                children: [
                  cardListServices('descripcion',
                      '${this.widget.businessServices[index].descripcion}\n \n \n \n \n \n \n'),
                  cardListServices('duracion',
                      '${this.widget.businessServices[index].duracion} \n \n \n \n \n \n \n'),
                  cardQuestions('preguntas', 'Preguntas', context, index),
                ],
              ),
            );
          }),
    );
  }

  Widget cardQuestions(
      String headerData, String valueData, BuildContext context, int index) {
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
          Container(
            height: 200,
            child: ListView.builder(
                itemCount: datita.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardListServices('${datita[index].descripcion}',
                      '${datita[index].respuesta}');
                }),
          ),
        ],
      ),
    );
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
