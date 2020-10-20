
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/doctors_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';

class EventSearchDelegate extends SearchDelegate<Doctores>{

  @override
  final String searchFieldLabel;
  final List<Doctores> historial;

  EventSearchDelegate(this.searchFieldLabel,this.historial);

  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      )
    ];   
    }
  

    @override
    Widget buildLeading(BuildContext context) {
      var doctor = new DoctorCtrl();
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.close(context, null),
      );
    }
  

    @override
    Widget buildResults(BuildContext context) {

      if(query.trim().length == 0) {
        return Center(child: Text(''));
      }

      Future<List<Doctores>> futureDoctor;
      futureDoctor = DoctorCtrl.listarPrueba(query);
      print(futureDoctor);

      return FutureBuilder(
        future: futureDoctor,
        builder: (BuildContext context, AsyncSnapshot snapshot) { 

          if ( snapshot.hasData ) {
            return _showDoctores( snapshot.data );
          }

          if ( snapshot.hasError ) {
            print(snapshot.data);
            return ListTile( title: Text('No hay nada con ese Termino') );
          }
          
          return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
          );
        },
      );
      
    }
  

    @override
    Widget buildSuggestions(BuildContext context) {
    return _showDoctores(this.historial);
    
  }

  Widget _showDoctores(List<Doctores> doctores){
    return ListView.builder(
      itemCount: doctores.length,
      itemBuilder: (context, i){
        final doctor = doctores[i];

        return ListTile(
          leading: Image.network("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png", width: 45,),
          title: Text(doctor.doctor),
          onTap: (){
            this.close(context, doctor);
          },
        );
      },
    );
  }
  
}

