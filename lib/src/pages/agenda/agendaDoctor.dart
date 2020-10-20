import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_event.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:provider/provider.dart';
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
  List<dynamic> _selectedEvents;
  List<EventosModelo> eventosModel;
  List<EventosModeloUsuario> eventosModeUsuario;
  EventosHoldProvider eventosProvider;
  bool prueba = true;
  

  @override
  void initState() { 
    super.initState();
    _events = {};
    _selectedEvents = [];
    _controller = CalendarController();    
  }


  Map<DateTime, List<dynamic>> _eventsGet(List<EventosModelo> events){
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) { 
      DateTime date = DateTime(event.fecha.year, event.fecha.month, event.fecha.day
      , event.fecha.hour, event.fecha.minute);
      if(data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    eventosProvider = Provider.of<EventosHoldProvider>(context);
    Future<List<EventosModelo>> futureEvents;
    futureEvents = EventosCtrl.listarEventos(userinfo.correo);

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<EventosModelo>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.isNotEmpty){
              _events = _eventsGet(snapshot.data);
            }
          }

          if(snapshot.hasError){
            print(snapshot.hasError.toString());
          }

           return SingleChildScrollView(
            child: Column(
              children: <Widget>[TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                events: _events,
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.blueGrey[500],
                  selectedColor: Colors.red
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  centerHeaderTitle: true,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (day, events) {
                  print(userinfo.fotoPerfil);
                  
                  setState(() {
                    if(events.isNotEmpty){
                     _selectedEvents = events;
                     print("Si hay eventos en este día");               
                     
                    } else{
                      print("No hay eventos en este día");
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
                      borderRadius: BorderRadius.circular(10)
                    ),
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
                      borderRadius: BorderRadius.circular(10)
                    ),
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

              Container(
                    child: Column(
                      children: [
                        if(_selectedEvents != null)
                         ..._selectedEvents.map((e) => Container(       
                           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.green[100],
               border: Border.all(
                 color: Colors.black,
               ),
                           ),
                           child: Column(
               children: [
                 Row(
                children: [
                  SizedBox(width: 5,),
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(userinfo.fotoPerfil),
                          fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  SizedBox(width: 10,),
                  Flexible(
                  child: ListTile(              
                    title: Text(e.servicio),
                    subtitle: Text(e.fecha.toString()),
                    onTap: () {
                      print(e.fecha.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      ViewEvent(eventosModeloGlobal: e)
                      )
                      );
                    },
                  ),
                  ),       
                ],
                 )
               ],
                           ),
                         ),
                         )
                      ],
                    ), //
                  ),
              ]
               ),

           );

        },
      ),
      floatingActionButton: floatingButon(prueba),
    );
  }

  Widget floatingButon(bool prueba){
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'addagenda'),
      );
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

