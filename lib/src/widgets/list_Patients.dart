import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/userPatients_models.dart';

class ListaPacientes extends StatelessWidget {
  final List<Paciente> usuariosPacientes;

  const ListaPacientes(this.usuariosPacientes);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.usuariosPacientes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.account_circle),
            /*CircleAvatar(
              //backgroundImage: Color(Colors.blue),
              radius: 30.0,
            ),*/
            title: Text(this.usuariosPacientes[index].paciente),
            subtitle: Text(this.usuariosPacientes[index].correo),
            trailing: FlatButton(
              onPressed: () {
                
              },
              child: Text(
                'Seguir',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepPurpleAccent[200],
            ),
            onTap: () {
              //Freddo aqui va tu interfaz de usuario
              //Navigator.pushNamed(context, 'pruebaUser');
            },
          );
        });
  }
}
