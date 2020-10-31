
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/receta_medica.dart';


class ViewEvent extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;

  const ViewEvent({Key key, this.eventosModeloGlobal, this.currentuser}) : super(key: key);

  @override
  _ViewEventState createState() => _ViewEventState();
  
}

class _ViewEventState extends State<ViewEvent> {
  final formkey = new GlobalKey<FormState>();
  String doctor, email, descripcion, servicio;
  DateTime fecha;
  TextEditingController controlador = TextEditingController();
  TextEditingController controladorCorreoUser = TextEditingController();
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorApellidoUser = TextEditingController();
  TextEditingController controladorFecha = TextEditingController();
  bool document = true;
  final format = DateFormat("yyyy-MM-dd");

  Doctores doctorSeleccionado;
  List<Doctores> historial = [];

  Future<void> cupertinoDialog(EventosModelo eventos, BuildContext context) async{
    switch(await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Cancelar Cita'),
          content: Text('¿Desea cancelar esta cita?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'Aceptar');
              },
              child: const Text('Aceptar'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'Cancelar');
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    )){
      case 'Aceptar':
      print(eventos.idcita);
        EventosCtrl.actualizarEventosDenied(eventos.idcita).then((value) {
            if (value) {
              print('Si Wey');
            } else {
              print('No');
            }
          });
        Navigator.pop(context, 'agendaUser');
        break;
      case 'Cancelar':
        print('Cancelar');
        break;
    }
  }
  
  @override
  void initState() {
    super.initState();
    controladorCorreoUser.text = widget.eventosModeloGlobal.correo;
    controladorNombreUser.text = widget.eventosModeloGlobal.paciente;
    controladorApellidoUser.text = widget.eventosModeloGlobal.paciente;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Detalles de la Cita", style: TextStyle(color: Colors.black, fontSize: 35),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
          child: Column(   
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,       
            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [

                      //Container Usuario
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[900],
                                borderRadius: BorderRadius.all(Radius.circular(20)),            
                              ),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Column(                 
                                children: [
                                  //Correo Usuario
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: controladorCorreoUser,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.blueGrey[600],
                                            labelText: "Correo Electrónico",
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            enabled: false,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                          ),
                                         ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(                                    
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(widget.eventosModeloGlobal.foto),
                                            fit: BoxFit.fill
                                          ),
                                          color: Colors.amber
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  //Nombres Usuario
                                  TextField(
                                    controller: controladorNombreUser,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.blueGrey[600],
                                      labelText: "Nombres",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      enabled: false,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  //Apellidos Usuario
                                  TextField(
                                    controller: controladorApellidoUser,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.blueGrey[600],
                                      labelText: "Apellidos",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      enabled: false,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      //Servicio
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: new TextFormField(
                              decoration: InputDecoration(   
                                //labelText: "Servicio",                         
                                filled: true,
                                fillColor: Colors.white,
                                enabled: false,
                                hintText: widget.eventosModeloGlobal.servicio,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                              onSaved: (value) => servicio = value,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(                                    
                            height: 60,
                            width: 60,
                            child: GestureDetector(
                              child: Icon(Icons.add_box),
                              onTap: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RecetaMedica(
                                  eventosModeloGlobal: widget.eventosModeloGlobal, currentuser: widget.currentuser,)));
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      //Descripcion
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: new TextFormField(
                              maxLines: 3,
                              decoration: InputDecoration(   
                                //labelText: "Descripción",                         
                                filled: true,
                                fillColor: Colors.white,
                                enabled: false,
                                hintText: widget.eventosModeloGlobal.descripcion,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                              onSaved: (value) => descripcion = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),                
                      //Fecha y Hora
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Fecha
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                //labelText: "Fecha",
                                filled: true,
                                enabled: false,
                                hintText: widget.eventosModeloGlobal.fecha.year.toString()+"/"+widget.eventosModeloGlobal.fecha.month.toString()
                                +"/"+widget.eventosModeloGlobal.fecha.day.toString(),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          //Hora
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                //labelText: "Fecha",
                                filled: true,
                                enabled: false,
                                hintText: widget.eventosModeloGlobal.fecha.hour.toString()+":"+widget.eventosModeloGlobal.fecha.minute.toString(),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),        
                      //Botones
                      // Center(
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Expanded(
                      //         child: RaisedButton(
                      //           onPressed: (){
                      //             cupertinoDialog(widget.eventosModeloGlobal, context);
                      //           },
                      //           child: Text("Cancelar Cita"),
                      //         ),
                      //       ),
                      //       SizedBox(width: 10,),
                      //       Expanded(
                      //         child: RaisedButton(
                      //           onPressed: (){
                                  
                      //           },
                      //           child: Text("Editar Cita"),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}