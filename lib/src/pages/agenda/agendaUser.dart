import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_eventUser.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class AgendaUser extends StatefulWidget {
  final CurrentUsuario currentuser;
  const AgendaUser({Key key, this.currentuser}) : super(key: key);
  @override
  _AgendaUserState createState() => _AgendaUserState();
}

class _AgendaUserState extends State<AgendaUser> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  List<EventosModeloUsuario> eventosModel2;
  EventosHoldProvider eventosProvider;
  int countSelectedDay, countList;
  DateTime selectedDay;

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

  Map<DateTime, List<dynamic>> _eventsGet(List<EventosModeloUsuario> events){
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.fecha.year, event.fecha.month,
          event.fecha.day, event.fecha.hour, event.fecha.minute);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  List<EventosModeloUsuario> transormar(List<dynamic> dinamico) {
    var temporal2 = List<EventosModeloUsuario>.from(dinamico);
    return temporal2;
  }

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    eventosProvider = Provider.of<EventosHoldProvider>(context);
    Future<List<EventosModeloUsuario>> futureEvents;
    futureEvents = EventosCtrl.listarEventosUsuarios(userinfo.correo);

    return Scaffold(
      backgroundColor: Colors.white,
      
      body: FutureBuilder<List<EventosModeloUsuario>>(
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
                    )
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day, events) {
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
                  },
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
              ),
              //Eventos
              if (countList != 0)
              Card(
                child: ExpansionTile(
                  tilePadding:
                      EdgeInsets.fromLTRB(_screenSize.width * 0.060, 0, 12, 1),
                  leading: Icon(
                    MdiIcons.bookOpenPageVariant,
                    color: Colors.lightBlue,
                  ),
                  title: Text(
                    selectedDay.year.toString()+'-'+selectedDay.month.toString()+'-'+selectedDay.day.toString(),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  subtitle: Text('Usted tiene $countSelectedDay citas agendadas'),
                  children: [
                    for(EventosModeloUsuario eventos in eventosModel2)
                    Dismissible(
                      key: ValueKey(eventos),
                      child: ListTile(
                        title: Text(eventos.servicio),
                        subtitle: Text(eventos.fecha.toString()),
                        onTap: () {
                          print("object");
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewEventUser(
                                  eventosModeloGlobal: eventos,)));
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
                                          print('Si Wey');
                                        } else {
                                          print('No');
                                        }
                                      });
                                    });
                                    
                                    Navigator.of(context).pop(false);
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
              
              // ExpansionTile(
              //       title: null,
              //       children: [
              //         if (_selectedEvents != null)
              //             ..._selectedEvents.map(
              //   (e) => Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.green[100],
              //       border: Border.all(
              //     color: Colors.black,
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //     Row(
              //       children: [
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Container(
              //           width: 50,
              //           height: 50,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //     image:
              //   NetworkImage(userinfo.fotoPerfil),
              //     fit: BoxFit.fill),
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //   color: Colors.black,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Flexible(
              //           child: ListTile(
              //             title: Text(e.servicio),
              //             subtitle: Text(e.fecha.toString()),
              //             onTap: () {
              //   print(e.fecha.toString());
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => 
              //     ViewEventUser(
              //         eventosModeloGlobal: e, correo: userinfo.correo, nombres: userinfo.nombres, apellidos: userinfo.apellidos, foto: userinfo.fotoPerfil,
              //         )
              //       )
              //   );
              //             },
              //           ),
              //         ),
              //       ],
              //     )
              //       ],
              //     ),
              //   ),
              //             )
              //       ],
              //     )
            ]),
          );
        },
      ),
      floatingActionButton: floatingButon(userinfo),
    );
  }

  Widget floatingButon(CurrentUsuario userinfo) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('object');
          Navigator.pushNamed(context, 'addagenda', arguments: userinfo);
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
