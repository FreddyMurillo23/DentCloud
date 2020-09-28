import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/event_provider.dart';
import 'package:provider/provider.dart';

class DoctorEventsPendients extends StatefulWidget {
  @override
  _DoctorEventsPendientsState createState() => _DoctorEventsPendientsState();
}

class _DoctorEventsPendientsState extends State<DoctorEventsPendients> {
  EventosProvider eventosProvider;

  @override
  Widget build(BuildContext context) {
    eventosProvider = Provider.of<EventosProvider>(context);
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ListTile(
          title: Text("This is my Little"),
          trailing: Wrap(
            spacing: 12,
            children: [
              Icon(Icons.call),
              Icon(Icons.message)
            ],
          ),
        ),
      ),
    );
  }
}