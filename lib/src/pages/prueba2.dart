import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/apointment_ctrl.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:muro_dentcloud/src/models/event_model.dart';

class Agenda3 extends StatefulWidget {
  @override
  _Agenda3State createState() => _Agenda3State();
}

class _Agenda3State extends State<Agenda3> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    
    super.initState();
        _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    _controller = CalendarController();
    
  }


  Map<DateTime, List<dynamic>> _eventsGet(List<EventosModelo> events){
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) { 
      DateTime date = DateTime(event.fecha.year, event.fecha.month, event.fecha.day
      , 12);
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
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: FutureBuilder(
        future: futureEvents,
        builder: (context, snapshot) {
          if(snapshot.hasData){
           _events = _eventsGet(snapshot.data);
          }

          if(snapshot.hasError){
            print(snapshot.hasError.toString());
          }

           return SingleChildScrollView(
              child: Column(
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
               ..._selectedEvents.map((e) => Text(e.toString())),
               
               
               ]
             ),
           );

        },
      ),
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

