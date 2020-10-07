import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';


// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  Future<List<EventModel>> futureEvents;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DataProvider eventosCtrl;
  EventModel eventos;
  final ptm = new DataProvider();
  bool prueba = true;
  EventosProvider eventosProvider;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {
      DateTime(2020, 9, 20) : [
        'Event A' , 'Event B', 'Event C'
      ]
    };
    _selectedEvents = [];
    
    
  }

  


  @override
  Widget build(BuildContext context) {
    eventosProvider = Provider.of<EventosProvider>(context);

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(

              onHeaderTapped: (focusedDay) => print(focusedDay),

              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        //borderRadius: BorderRadius.circular(10.0)
                        ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                    ),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        //borderRadius: BorderRadius.circular(10.0)
                        ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                markersBuilder: (context, date, events, holidays)  {
                  final children = <Widget>[];

                  if(events.isNotEmpty){
                    children.add(
                      Positioned(
                        right: 1,
                        bottom: 1,
                        child: _buildEventsMarker(date, events),
                      )
                    );
                  }
                  return children;
                },
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((e) => ListTile(
              title: Text(e),
              onTap: (){print(e);},
            ))
          
          ],
        ),
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
      child: Icon(Icons.ac_unit),
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

