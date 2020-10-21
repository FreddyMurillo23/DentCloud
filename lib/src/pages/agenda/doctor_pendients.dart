import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:provider/provider.dart';

class DoctorEventsPendients extends StatefulWidget {
  @override
  _DoctorEventsPendientsState createState() => _DoctorEventsPendientsState();
}

class _DoctorEventsPendientsState extends State<DoctorEventsPendients> {
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[100],
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),                    
                      Container(                                    
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
                            fit: BoxFit.fill
                          ),
                          color: Colors.amber
                        ),
                      ),

                      SizedBox(width: 10,),

                      Flexible(
                        child: ListTile(
                          title: Text(eventos.paciente),
                          subtitle: Text(eventos.fecha.month.toString()+"/"+eventos.fecha.day.toString()+"  -  "+eventos.fecha.hour.toString()+":"+eventos.fecha.minute.toString()),
                          // trailing: Wrap(
                          //   spacing: 5,
                          //   children: [
                          //     RaisedButton(
                          //       onPressed: (){

                          //       }, 
                          //       color: Colors.greenAccent[400],
                          //       child: Text("Gestionar"),
                          //     ),
                          //     RaisedButton(
                          //       onPressed: (){
                          //         print(eventos.idcita);
                          //         EventosCtrl.actualizarEventosApproved(eventos.idcita);
                          //       },
                          //       color: Colors.purple[900],
                          //       child: Text("Aceptar"),
                          //     )
                          //   ],
                          // ),
                          trailing: Wrap(
                            children: [
                              SizedBox(
                                width: 40,
                                child: FlatButton(
                                  // color: Colors.red,
                                  shape: CircleBorder(),
                                  onPressed: (){
                                    print('xD');
                                  }, 
                                  child: Icon(Icons.edit)
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: FlatButton(
                                  shape: CircleBorder(),
                                  onPressed: (){
                                    EventosCtrl.actualizarEventosApproved(eventos.idcita);
                                  }, 
                                  child: Icon(Icons.check)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                
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