import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class DoctorEventsPendients extends StatefulWidget {
  @override
  _DoctorEventsPendientsState createState() => _DoctorEventsPendientsState();
}

class _DoctorEventsPendientsState extends State<DoctorEventsPendients> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  EventosHoldProvider eventosProvider;
  EventosCtrl eventosCtrl;

  @override
  Widget build(BuildContext context) {
    eventosProvider = Provider.of<EventosHoldProvider>(context);
    eventosProvider.listarEventosonHold("hvargas@utm.ec");


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        
      ),
      body: SingleChildScrollView(
        child: Selector<EventosHoldProvider,List<EventosModelo>>(
          selector: (context, model) => model.eventosHold,
          builder: (context, value, child) => Column(
            children: [
              SizedBox(height: 10,),
              if(value.length > 0) ...[
 
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Solicitudes",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35, 
                      ),                   
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                for(EventosModelo eventos in value)
                ExpansionTileCard(
                  title: Text(eventos.paciente),
                  subtitle: Text(eventos.fecha.month.toString()+"/"+eventos.fecha.day.toString()+"  -  "+eventos.fecha.hour.toString()+":"+eventos.fecha.minute.toString()),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(child: Padding(
                      padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                      child: Text('Servicio: '+eventos.servicio),
                    ), alignment: Alignment.centerLeft,),
                    Align(child: Padding(
                      padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                      child: Text('Descripcion: '+eventos.descripcion, textAlign: TextAlign.justify,),
                    ), alignment: Alignment.centerLeft,),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            cardB.currentState?.expand();
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.check,color: Colors.green,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Approved',style: TextStyle(color: Colors.green),),
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            cardB.currentState?.collapse();
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.cancel, color: Colors.red),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Denied',style: TextStyle(color: Colors.red),),
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            cardB.currentState?.toggleExpansion();
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.edit, color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Edit', style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.green[100],
                //     border: Border.all(
                //       color: Colors.black,
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       SizedBox(width: 10,),                    
                //       Container(                                    
                //         height: 60,
                //         width: 60,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(10)),
                //           image: DecorationImage(
                //             image: NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
                //             fit: BoxFit.fill
                //           ),
                //           color: Colors.amber
                //         ),
                //       ),

                //       SizedBox(width: 10,),

                //       Flexible(
                //         child: ListTile(
                //           title: Text(eventos.paciente),
                //           subtitle: Text(eventos.fecha.month.toString()+"/"+eventos.fecha.day.toString()+"  -  "+eventos.fecha.hour.toString()+":"+eventos.fecha.minute.toString()),
                //           trailing: Wrap(
                //             children: [
                //               SizedBox(
                //                 width: 45,
                //                 child: Center(
                //                   child: FlatButton(
                //                     shape: CircleBorder(),
                //                     onPressed: (){
                //                       print('xD');
                //                     }, 
                //                     child: Center(child: Center(child: Icon(Icons.edit)))
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 45,
                //                 child: Center(
                //                   child: FlatButton(
                //                     shape: CircleBorder(),
                //                     onPressed: (){
                //                       EventosCtrl.actualizarEventosApproved(eventos.idcita);
                //                     }, 
                //                     child: Center(child: Center(child: Icon(Icons.check)))
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
                
              ] else ...[
                Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
              ]
            ],
          ),
        )
      ),
    );
  }
}