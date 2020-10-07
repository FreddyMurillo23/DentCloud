import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/view_event.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';


class Agenda3 extends StatefulWidget {
  @override
  _Agenda3State createState() => _Agenda3State();
}

class _Agenda3State extends State<Agenda3> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  List<EventosModelo> eventosModel;
  List<EventosModelo> eventosModel2;
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
    Future<List<EventosModelo>> futureEvents;
    futureEvents = EventosCtrl.listarEventos("hvargas@utm.ec");

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
            eventosModel = snapshot.data;
            if(eventosModel.isNotEmpty){
              _events = _eventsGet(eventosModel);
            }
          }

          if(snapshot.hasError){
            print(snapshot.hasError.toString());
          }

           return Column(
            children: <Widget>[TableCalendar(
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
                    color: Colors.blueGrey[500]
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
                    color: Colors.red
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              calendarController: _controller,
            ),
            Divider(),

            if(_selectedEvents != null)
            ..._selectedEvents.map((e) => SingleChildScrollView(
                          child: ListTile(
                
                title: Text(e.servicio),
                subtitle: Text(e.fecha.toString()),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  ViewEvent(eventosModeloGlobal: e)
                  )
                  );
                },
              ),
            ),),
            
            ]
             );

        },
      ),
      floatingActionButton: floatingButon(prueba),
    );
  }

  Widget floatingButon(bool prueba){
    if(prueba==true){
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'addagenda'),
      );
    }
    return FloatingActionButton(
      child: Icon(Icons.list),
      onPressed: () {
        Navigator.pushNamed(context, 'eventosPendientes');
      } 
    );
  }
}

