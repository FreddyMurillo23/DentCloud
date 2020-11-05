import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/services_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_eventDoctor.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class Agenda3 extends StatefulWidget {
  final CurrentUsuario currentuser;
  const Agenda3({Key key, this.currentuser}) : super(key: key);
  @override
  _Agenda3State createState() => _Agenda3State();
}

class _Agenda3State extends State<Agenda3> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  ServicioProvider servicioProvider;
  List<dynamic> _selectedEvents;
  List<EventosModelo> eventosModel2;
  List<EventosModeloUsuario> eventosModeUsuario;
  EventosHoldProvider eventosProvider;
  int countSelectedDay, countList;
  Map dropDownItemsMap;
  DateTime selectedDay;
  List<DropdownMenuItem> listServicio = List<DropdownMenuItem>();
  Servicios _selectedItem;
  final date = DateFormat("yyyy-MM-dd");
  final time = DateFormat("HH:mm");
  DateTime fecha, dia;
  TimeOfDay hora;
  String servicio;
  final formkey = new GlobalKey<FormState>();
  

  @override
  void initState() {
    super.initState();
    _events = {};
    _selectedEvents = [];
    _controller = CalendarController();
    countSelectedDay = 0;
    selectedDay = DateTime.now();
    eventosModel2 = [];
    countList = 0;
  }
  
  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  Map<DateTime, List<dynamic>> _eventsGet(List<EventosModelo> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.fecha.year, event.fecha.month,
          event.fecha.day, event.fecha.hour, event.fecha.minute);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  List<EventosModelo> transormar(List<dynamic> dinamico) {
    var temporal2 = List<EventosModelo>.from(dinamico);
    return temporal2;
  }

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

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    eventosProvider = Provider.of<EventosHoldProvider>(context);
    Future<List<EventosModelo>> futureEvents;
    futureEvents = EventosCtrl.listarEventos(userinfo.correo);
    servicioProvider = Provider.of<ServicioProvider>(context);
    servicioProvider.listarServicios(userinfo.cedula+'001');

    void valideField(EventosModelo eventos){
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();
      if(servicio == null || dia == null || hora == null) {
        print('Algo nulo chamo');
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
          setState(() {
            _selectedItem = null;
            countList = 0;
          });
          
          Navigator.pop(context);
        }   
      print("Form is valid");
    } else {
      print('Form is invalid');
    }
  }

  void _onLoading(BuildContext context2) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.of(context2).pop(false); //pop dialog
    });
  }

    _openPopup(context, EventosModelo eventos) {
    dia = DateTime(eventos.fecha.year, eventos.fecha.month, eventos.fecha.day);
    servicio = eventos.idservicio;
    Alert(
        context: context,
        title: "Editar Cita",
        content: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Selector<ServicioProvider, List<Servicios>>(
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
                            setState(() {
                              this._selectedItem = dropDownItemsMap[selected];
                              servicio = _selectedItem.servicioid.toString();
                            });
                          },
                          hint: new Text(
                            _selectedItem != null ? _selectedItem.descripcion: eventos.servicio.toString(),
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
                      validator: (value) => value == null
                      ? 'Este campo no puede estar vacio'
                      : null,
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
                        } else if(dateTime.hour == 0){
                          return "Ingrese una hora valida";
                        }
                        print(dateTime.hour.toString());
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
              valideField(eventos);            
            },
            child: Text(
              "Actualizar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.red,
            onPressed: () { 
              _selectedItem = null;
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
      body: FutureBuilder<List<EventosModelo>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              _events = _eventsGet(snapshot.data);
            }
          }

          if (snapshot.hasError) {
            print(snapshot.hasError.toString());
          }       

          return SingleChildScrollView(
            child: Column(children: <Widget>[
              Card(
                child: TableCalendar(
                  initialSelectedDay: null,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  events: _events,
                  locale: 'es',
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Colors.blueGrey[500],
                      selectedColor: Colors.red),
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      centerHeaderTitle: true,
                      titleTextStyle: const TextStyle(
                        fontSize: 17,
                      )),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                 /* onDaySelected: (day, events) {
                    setState(() {
                      if (events.isNotEmpty) {
                        _selectedEvents = events;
                        eventosModel2 = transormar(_selectedEvents);
                        selectedDay = day;
                        countList = eventosModel2.length;
                        print(countList.toString());
                        countSelectedDay = events.length;
                      } else {
                        eventosModel2 = [];
                        countList = eventosModel2.length;
                        print(countList);
                        selectedDay = day;
                        countSelectedDay = 0;
                        _selectedEvents.clear();
                      }
                    });
                  },*/
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[500],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];

                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }
                      return children;
                    },
                  ),
                  calendarController: _controller,
                ),
                elevation: 10,
                margin: new EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),

              //Eventos
              if (countList != 0)
              Card(
                child: ExpansionTile(
                  maintainState: false,
                  onExpansionChanged: (value) {
                    print('Exploooosion');
                  },
                  tilePadding:
                      EdgeInsets.fromLTRB(_screenSize.width * 0.060, 0, 12, 1),
                  leading: Icon(
                    MdiIcons.bookOpenPageVariant,
                    color: Colors.lightBlue,
                  ),
                  title: Text(
                    selectedDay.year.toString()+' - '+selectedDay.month.toString()+' - '+selectedDay.day.toString(),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  subtitle: Text('Usted tiene $countSelectedDay citas agendadas'),
                  children: [
                    for(EventosModelo eventos in eventosModel2)
                    Dismissible(
                      key: ValueKey(eventos),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          child: FadeInImage.assetNetwork(placeholder: 'assets/loading.gif', image: eventos.foto),
                        ),
                        title: Text(eventos.servicio),
                        subtitle: Text(eventos.fecha.year.toString()+"/"+eventos.fecha.month.toString()+"/"+eventos.fecha.day.toString()),
                        onTap: () {
                          //!
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewEvent(
                                  eventosModeloGlobal: eventos, currentuser: userinfo,)));
                        },
                        onLongPress: () {
                          _openPopup(context, eventos);
                        },
                      ),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) async{
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Cancelar Cita'),
                              content: const Text("¿Está seguro que desea cancelar esta cita?"),
                               actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                      eventosModel2.remove(eventos);
                                      EventosCtrl.actualizarEventosDenied(eventos.idcita).then((value) {
                                        if (value) {
                                          setState(() {
                                            eventosModel2.remove(eventos);
                                            countSelectedDay--;
                                            countList = eventosModel2.length;
                                            
                                          });                             
                                        } else {
                                        }
                                      });
                                    });  
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: new Container(
                                            height: 100,
                                            child: new Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                new CircularProgressIndicator(),
                                                new SizedBox(width: 10,),
                                                new Text(" Cargando"),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    new Future.delayed(new Duration(seconds: 2), () {
                                      Navigator.of(context).pop(false); //pop dialog
                                    });
                                    new Future.delayed(new Duration(milliseconds: 1000), () {
                                      Navigator.of(context).pop(false); //pop dialog
                                    });                                  
                                    },
                                    child: const Text("Aceptar")
                                  ),
                                  FlatButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Cancelar"),
                                    
                                  ),
                                ],
                            );
                          },
                        );
                      },
                      background: Container(
                        child: Icon(Icons.delete, color: Colors.red,),
                        alignment: Alignment.center,
                      ),
                      secondaryBackground: Container(
                        child: Icon(Icons.delete, color: Colors.red,),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                  
                ),
                elevation: 10,
                margin: new EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),

              Container(
                height: 100,
              ),
            ]),
          );
        },
      ),
      floatingActionButton: floatingButon(userinfo),
    );
  }

  Widget floatingButon(CurrentUsuario userinfo) {
    return FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () {
          Navigator.pushNamed(context, 'eventosPendientes',
              arguments: userinfo);
        });
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _controller.isSelected(date)
            ? Colors.brown[500]
            : _controller.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
