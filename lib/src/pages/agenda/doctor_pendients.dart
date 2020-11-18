import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:provider/provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DoctorEventsPendients extends StatefulWidget {
  final CurrentUsuario currentuser;

  const DoctorEventsPendients({Key key, this.currentuser}) : super(key: key);

  @override
  _DoctorEventsPendientsState createState() => _DoctorEventsPendientsState();
}

class _DoctorEventsPendientsState extends State<DoctorEventsPendients> {
  EventosHoldProvider eventosProvider;
  EventosCtrl eventosCtrl;
  ServicioProvider servicioProvider;
  ServicioProviderNuevo servicioProviderNuevo;
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  final formkey = new GlobalKey<FormState>();
  Map dropDownItemsMap;
  Servicios _selectedItem;
  String servicio;
  final date = DateFormat("yyyy-MM-dd");
  final time = DateFormat("HH:mm");
  DateTime fecha, dia;
  TimeOfDay hora;

  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    eventosProvider = Provider.of<EventosHoldProvider>(context);
    servicioProviderNuevo = Provider.of<ServicioProviderNuevo>(context);
    eventosProvider.listarEventosonHold(userinfo.correo);
    servicioProvider = Provider.of<ServicioProvider>(context);
    servicioProvider.listarServicios(userinfo.cedula+'001');

  List<DropdownMenuItem> getSelectOptions(List<Servicios> servicios){
    dropDownItemsMap = new Map();
    listServicio.clear();
    servicios.forEach((servicios) { 
      int index = servicios.servicioid;
      dropDownItemsMap[index] = servicios;
      listServicio.add(new DropdownMenuItem(
        child: Text(servicios.descripcion),
        value: servicios.servicioid,
      ));
    });
    return listServicio;
  }
  
    //Cupertino Dialog
    Future<void> cupertinoDialog(EventosModeloHold eventos, BuildContext context) async {
      switch (await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Rechazar Cita'),
            content: Text('¿Desea rechazar esta cita?'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'Aceptar');
                },
                child: const Text('Aceptar'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  print(userinfo.correo);
                  Navigator.pop(context, 'Cancelar');
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        },
      )) {
        case 'Aceptar':
          EventosCtrl.actualizarEventosDenied(eventos.idcita).then((value) {
            if (value) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Cita Rechazada con Éxito"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Error al Rechazar la Cita"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
              ));
            }
          });
          print('Cancelar');
          break;
        case 'Cancelar':
          print('Cancelar');
          break;
      }
    }
  
  _openPopup(context, EventosModeloHold eventos) {
    dia = DateTime(eventos.fecha.year, eventos.fecha.month, eventos.fecha.day);
    Alert(
        context: context,
        title: "Editar Cita",
        content: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Selector<ServicioProviderNuevo, List<Servicios>>(
                selector: (context, model) => model.servicios,
                builder: (context, servicios, child) => Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          items: getSelectOptions(servicios), 
                          onChanged: (selected) {
                            this._selectedItem = dropDownItemsMap[selected];
                            servicio = _selectedItem.servicioid.toString();
                            print(servicio);
                            setState(() {
                              this._selectedItem = dropDownItemsMap[selected];
                              servicio = _selectedItem.servicioid.toString();
                            });
                          },
                          hint: new Text(
                            _selectedItem != null 
                            ? _selectedItem.descripcion 
                            : "Servicios",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    //Fecha Edicion
                    DateTimeField(
                      initialValue: eventos.fecha,
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        filled: true,
                        enabled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        prefixIcon: Icon(Icons.date_range)
                      ),
                      format: date,
                      onShowPicker: (context, currentValue) async {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (value) => dia = value,
                    ),
                    SizedBox(height: 5,),
                    //Hora Edicion
                    DateTimeField(
                      initialValue: eventos.fecha,
                      decoration: InputDecoration(
                        labelText: "Hora",
                        filled: true,
                        enabled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        prefixIcon: Icon(Icons.date_range)
                      ),
                      format: time,
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        hora = time;
                        return DateTimeField.convert(time);
                      },
                      validator: (DateTime dateTime){
                        if(dateTime == null) {
                          return "Este campo no puede estar vacio";
                        }
                        return null;
                      },
                    ),
                  ],
                )
              )
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: Colors.green,
            onPressed: () {            
              if(servicio == null || dia == null || hora == null) {
              } else{ 
                fecha = combine(dia, hora);
                EventosCtrl.actualizarEventosDatos(eventos.idcita, servicio, fecha).then((value) {
                  if(value) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cita Actualizada con Éxito"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Error al Actualizar la Cita"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                    ));
                  }
                });
                Navigator.pop(context);
              }   
            },
            child: Text(
              "Actualizar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.red,
            onPressed: () { 
              Navigator.pop(context);
              },
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          "Solicitudes",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: SingleChildScrollView(
          child: Selector<EventosHoldProvider, List<EventosModeloHold>>(
        selector: (context, model) => model.eventosHold,
        builder: (context, value, child) => Column(
          children: [
            SizedBox(
              height: 10,
            ),
            if (value.length > 0) ...[
              for (EventosModeloHold eventos in value)
                ExpansionTileCard(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: Text(eventos.paciente),
                  subtitle: Text(eventos.fecha.month.toString() +
                      "/" +
                      eventos.fecha.day.toString() +
                      "  -  " +
                      eventos.fecha.hour.toString() +
                      ":" +
                      eventos.fecha.minute.toString()),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text('Servicio: ' + eventos.servicio),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'Descripcion: ' + eventos.descripcion,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        //Aceptar Cita
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            EventosCtrl.actualizarEventosApproved(
                                    eventos.idcita)
                                .then((value) {
                              if (value) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Cita Agendada con Éxito"),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Error al Agendar la Cita"),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text(
                                'Approved',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        //Rechazar Cita
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            cupertinoDialog(eventos, context);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.cancel, color: Colors.red),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text(
                                'Denied',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            servicioProviderNuevo.listarServiciosNuevo(userinfo.correo, eventos.ruc);
                            _openPopup(context, eventos);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ] else ...[
              
            ]
          ],
        ),
      )),
    );
  }
}
