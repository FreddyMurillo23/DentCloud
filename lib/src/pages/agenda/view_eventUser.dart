
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/agendaUser.dart';


class ViewEventUser extends StatefulWidget {
  final EventosModeloUsuario eventosModeloGlobal;
  final String correo, nombres, apellidos, foto;

  const ViewEventUser({Key key, this.eventosModeloGlobal, this.correo, this.nombres, this.apellidos, this.foto}) : super(key: key);

  @override
  _ViewEventUserState createState() => _ViewEventUserState();
  
}

class _ViewEventUserState extends State<ViewEventUser> {
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
    controladorCorreoUser.text = widget.correo;
    controladorNombreUser.text = widget.nombres;
    controladorApellidoUser.text = widget.apellidos;
    
  }

  //Cupertino Dialog
  Future<void> cupertinoDialog(EventosModeloUsuario eventos) async{
    switch(await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Cancelar Cita'),
          content: Text('¿Desea cancelar esta cita?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'Yes');
              },
              child: const Text('Yes'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, 'No');
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    )){
      case 'Yes':
        EventosCtrl.actualizarEventosDenied(eventos.idcita);
        Navigator.pop(context, 'agendaUser');
        print('yes');
        break;
      case 'No':
        print('No');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(   
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.max,       
    //       children: [

    //         Text("Detalles de la Cita", style: TextStyle(color: Colors.black, fontSize: 35),),

    //         Padding(
    //           padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
    //           child: Form(
    //             key: formkey,
    //             child: Column(
    //               children: [

    //                 //Container Usuario
    //                 Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: Container(
    //                         height: 250,
    //                         decoration: BoxDecoration(
    //                           color: Colors.blueGrey[900],
    //                           borderRadius: BorderRadius.all(Radius.circular(20)),            
    //                         ),
    //                         padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
    //                         child: Column(                 
    //                           children: [
    //                             //Correo Usuario
    //                             Row(
    //                               mainAxisSize: MainAxisSize.max,
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 Flexible(
    //                                   child: TextField(
    //                                     controller: controladorCorreoUser,
    //                                     decoration: InputDecoration(
    //                                       filled: true,
    //                                       fillColor: Colors.blueGrey[600],
    //                                       labelText: "Correo Electrónico",
    //                                       labelStyle: TextStyle(
    //                                         color: Colors.white,
    //                                       ),
    //                                       enabled: false,
    //                                       border: OutlineInputBorder(
    //                                         borderRadius: BorderRadius.all(Radius.circular(10)),
    //                                       )
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 10,),
    //                                 Container(                                    
    //                                   height: 60,
    //                                   width: 60,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                                     image: DecorationImage(
    //                                       image: NetworkImage(widget.foto),
    //                                       fit: BoxFit.fill
    //                                     ),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                             SizedBox(height: 15,),
    //                             //Nombres Usuario
    //                             TextField(
    //                               controller: controladorNombreUser,
    //                               decoration: InputDecoration(
    //                                 filled: true,
    //                                 fillColor: Colors.blueGrey[600],
    //                                 labelText: "Nombres",
    //                                 labelStyle: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                                 enabled: false,
    //                                 border: OutlineInputBorder(
    //                                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                                 )
    //                               ),
    //                             ),
    //                             SizedBox(height: 15,),
    //                             //Apellidos Usuario
    //                             TextField(
    //                               controller: controladorApellidoUser,
    //                               decoration: InputDecoration(
    //                                 filled: true,
    //                                 fillColor: Colors.blueGrey[600],
    //                                 labelText: "Apellidos",
    //                                 labelStyle: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                                 enabled: false,
    //                                 border: OutlineInputBorder(
    //                                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                                 )
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       )
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 15,),
    //                 //Doctor
    //                 Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: new TextFormField(
    //                         decoration: InputDecoration(   
    //                           //labelText: "Servicio",                         
    //                           filled: true,
    //                           fillColor: Colors.white,
    //                           enabled: false,
    //                           hintText: widget.eventosModeloGlobal.doctor,
    //                           border: OutlineInputBorder(
    //                             borderRadius: BorderRadius.all(Radius.circular(20)),
    //                           ),
    //                         ),
    //                         validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
    //                         onSaved: (value) => servicio = value,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 15,),
    //                 //Servicio
    //                 Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: new TextFormField(
    //                         decoration: InputDecoration(   
    //                           //labelText: "Servicio",                         
    //                           filled: true,
    //                           fillColor: Colors.white,
    //                           enabled: false,
    //                           hintText: widget.eventosModeloGlobal.servicio,
    //                           border: OutlineInputBorder(
    //                             borderRadius: BorderRadius.all(Radius.circular(20)),
    //                           ),
    //                         ),
    //                         validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
    //                         onSaved: (value) => servicio = value,
    //                       ),
    //                     ),
    //                     SizedBox(width: 5,),
    //                     Container(                                    
    //                       height: 60,
    //                       width: 60,
    //                       child: GestureDetector(
    //                         child: Icon(Icons.add_box),
    //                         onTap: () {
    //                           print('Hola');
    //                         },
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(height: 15,),
    //                 //Descripcion
    //                 Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: new TextFormField(
    //                         maxLines: 3,
    //                         decoration: InputDecoration(   
    //                           //labelText: "Descripción",                         
    //                           filled: true,
    //                           fillColor: Colors.white,
    //                           enabled: false,
    //                           hintText: widget.eventosModeloGlobal.descripcion,
    //                           border: OutlineInputBorder(
    //                             borderRadius: BorderRadius.all(Radius.circular(20)),
    //                           ),
    //                         ),
    //                         validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
    //                         onSaved: (value) => descripcion = value,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 15,),                
    //                 //Fecha y Hora
    //                 Row(
    //                   mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     //Fecha
    //                     Expanded(
    //                       child: TextFormField(
    //                         decoration: InputDecoration(
    //                           //labelText: "Fecha",
    //                           filled: true,
    //                           enabled: false,
    //                           hintText: widget.eventosModeloGlobal.fecha.year.toString()+"/"+widget.eventosModeloGlobal.fecha.month.toString()
    //                           +"/"+widget.eventosModeloGlobal.fecha.day.toString(),
    //                           fillColor: Colors.white,
    //                           border: OutlineInputBorder(
    //                             borderRadius: BorderRadius.all(Radius.circular(20)),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(width: 5,),
    //                     //Hora
    //                     Expanded(
    //                       child: TextFormField(
    //                         decoration: InputDecoration(
    //                           //labelText: "Fecha",
    //                           filled: true,
    //                           enabled: false,
    //                           hintText: widget.eventosModeloGlobal.fecha.hour.toString()+":"+widget.eventosModeloGlobal.fecha.minute.toString(),
    //                           fillColor: Colors.white,
    //                           border: OutlineInputBorder(
    //                             borderRadius: BorderRadius.all(Radius.circular(20)),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 15,),        
    //                 //Botones
    //                 Center(
    //                   child: Row(
    //                     mainAxisSize: MainAxisSize.max,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Expanded(
    //                         child: RaisedButton(
    //                           onPressed: (){
    //                             cupertinoDialog(widget.eventosModeloGlobal);
    //                           },
    //                           child: Text("Cancelar Cita"),
    //                         ),
    //                       ),
    //                       SizedBox(width: 10,),
    //                     ],
    //                   ),
    //                 ),

    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    
    
  }
  
}