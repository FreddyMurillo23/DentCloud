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
      appBar: AppBar(),
      body: ListTile(
        
      ),
    );
  }
}