import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class Agenda2 extends StatefulWidget {
  @override
  _Agenda2State createState() => _Agenda2State();
  
}

class _Agenda2State extends State<Agenda2> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  String pruebasString = "Hola";

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
    
  }
  
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(decodeMap(json.decode(prefs.getString
    ("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map){
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map){
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Demo Freddo'),

        actions: [
          RaisedButton(
            onPressed: (){          
              prefs.clear();
              })         
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              locale: 'en_US',
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events, holidays) {
                print(date.day);
                setState(() {
                  _selectedEvents = events;
                });
                print(date.toIso8601String());

              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
          
              title: Text(event),
              subtitle: Text(event),
              onTap: (){
                Text("data");
              },
            )),
          ],
        ),
      ),

      //Guardar Cita
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(

            context: context,
            builder: (context) => AlertDialog(
              title: Text("Chamo"),
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[

          FlatButton(
            child: Text("Save"),
            onPressed: (){
              
              if(_eventController.text.isEmpty) return;

              setState(() {
                if(_events[_controller.selectedDay] != null) {
                 // _eventController.text = pruebasString;
                _events[_controller.selectedDay].add(                
                  _eventController.text
                );
                print(_eventController.toString());
              } else{
                _events[_controller.selectedDay] = 
                [_eventController.text];
                print(_eventController.text);
              }
              prefs.setString("events", json.encode(encodeMap(_events)));
              _eventController.clear();
              Navigator.pop(context);
              });  
            },
          ),

          FlatButton(
            
            onPressed: (){Navigator.pop(context);}, 
            child: Text("Cancel")           
            )

        ],
            ),

            );
          },
        child: Icon(Icons.add),
      ),

      
    );
  }
}