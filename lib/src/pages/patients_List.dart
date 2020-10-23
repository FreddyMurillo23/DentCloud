import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/services/userPatients_service.dart';
import 'package:muro_dentcloud/src/widgets/list_Patients.dart';
import 'package:provider/provider.dart';

class ListPatientsBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsPatients = Provider.of<UserPatient>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListaPacientes(newsPatients.usuario),
    );
  }
}
