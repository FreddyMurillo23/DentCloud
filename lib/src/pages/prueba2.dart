import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'dart:convert';

class Agenda3 extends StatefulWidget {
  @override
  _Agenda3State createState() => _Agenda3State();
}

class _Agenda3State extends State<Agenda3> {
  Future<List<EventModel>> futureEvents;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DataProvider eventosCtrl;
  EventModel eventos;
  final ptm = new DataProvider();

  @override
  void initState() {
    
    super.initState();
        _controller = CalendarController();
    _events = {
      DateTime(2020, 9, 20) : [
        'Event A' , 'Event B'
      ]
    };
    _selectedEvents = [];
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: futureEvents,
          builder: null
          ),
      ),
    );
  }
}