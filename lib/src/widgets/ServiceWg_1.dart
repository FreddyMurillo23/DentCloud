import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';

import 'circle_button.dart';

class ServiceDataWg1 extends StatefulWidget {
  final ServiciosNegocio businessServices;
  final String ruc;
  const ServiceDataWg1(this.businessServices, this.ruc);

  @override
  _ServiceDataWgState createState() => _ServiceDataWgState();
}

class _ServiceDataWgState extends State<ServiceDataWg1> {
  List<PreguntasServicios> datita = [];
  DataProvider1 servicioProvider= new DataProvider1();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    List<dynamic> objeto= new List();
    return Column(
      children: [
        Container(
          // height: screenSize.height * 0.58,
          child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                datita = widget.businessServices.preguntas;
                return Container(
                  child: Column(
                    children: [
                      cardListServices('descripcion',
                          '${this.widget.businessServices.servicio}'),
                      cardListServices('duracion',
                          '${this.widget.businessServices.duracion}'),
                    datita.length>0
                    ?cardQuestions('preguntas', 'Preguntas', context)
                    :Container(),
                    ],
                  ),
                );
              }),
        ),
        SizedBox(height: 10),
        Center(
          child:Row(
          children: [
            SizedBox(width:screenSize.width*0.25,),
            CircleButton(
            icon: MdiIcons.delete,
            iconsize: 40.0,
             colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
            onPressed: (){
               _showDialog();

            }, 
          ),
          SizedBox(height: 10),
          CircleButton(
            icon: MdiIcons.leadPencil,
            iconsize: 40.0,
             colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
            onPressed: (){
                objeto.add(widget.businessServices);
                objeto.add(widget.ruc);
                Navigator.pushNamed(context, 'editPageService',arguments: objeto);
            }, 
          ),

          ],
        ), 
        ),
        

         
      ],
    );
  }


  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Eliminar Datos"),
          content: new Text("Se Elimino correctamente el servicio"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                 servicioProvider.deleteServices(widget.ruc, widget.businessServices.idServicio);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget cardQuestions(
      String headerData, String valueData, BuildContext context) {
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
            height: 150,
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
