
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';


class ViewEvent extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;

  const ViewEvent({Key key, this.eventosModeloGlobal}) : super(key: key);

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
  
  @override
  void initState() {
    super.initState();
    controladorCorreoUser.text = widget.eventosModeloGlobal.paciente;
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
                                          image: NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
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
                              print('Hola');
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
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              onPressed: (){},
                              child: Text("Cancelar"),
                            ),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}