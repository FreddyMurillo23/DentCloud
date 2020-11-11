
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/doctors_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:provider/provider.dart';

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
      // var doctor = new DoctorCtrl();
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Doctores docs = Doctores(cedula: "", correo: "", celular: "", doctor: "", fechanacimiento: DateTime.now(), foto: "");
          print(docs.cedula);
          this.close(context, docs);
        },
      );
    }
  

    @override
    Widget buildResults(BuildContext context) {
      ServicioProvider servicioProvider = Provider.of<ServicioProvider>(context);

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
            return _showDoctores( snapshot.data , servicioProvider);
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
      Future<List<Doctores>> futureDoctor;
      futureDoctor = DoctorCtrl.listarPrueba(query);
      ServicioProvider servicioProvider = Provider.of<ServicioProvider>(context);
      print(futureDoctor);

      return FutureBuilder(
        future: futureDoctor,
        builder: (context, snapshot) {

          List<Doctores> datos = snapshot.data;

          List<Doctores> suglist = query.isEmpty
          ? historial
          : datos.where((element) => datos == null
          ? []
          : element.doctor.startsWith(query)).toList();


          if ( snapshot.hasError ) {
            print("Wey No");
            return ListTile( title: Text('No hay nada con ese Termino') );
          }

          if ( snapshot.hasData ) {
          //  return _showDoctoresHistorial(suglist);
            return _showDoctores(suglist, servicioProvider);
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

  Widget _showDoctores(List<Doctores> doctores, ServicioProvider servicioProvider){
    
    return ListView.builder(
      itemCount: doctores.length,
      itemBuilder: (context, i){
        final doctor = doctores[i];

        return ListTile(
          leading: Image.network(doctor.foto, width: 45,),
          title: Text(doctor.doctor),
          onTap: (){
            print('Wey');
            servicioProvider.listarServicios(doctor.cedula+"001");
            this.close(context, doctor);
          },
        );
      },
    );
  }

  Widget _showDoctoresHistorial(List<Doctores> doctores){

    if (doctores == null) {
      return Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
      );
    } else {
      return ListView.builder(
      itemCount: doctores.length,
      itemBuilder: (context, i){
        final doctor = doctores[i];

        String fotoS;
        if(doctor.foto == ""){
          fotoS = "http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png";
        } else {
          fotoS = doctor.foto;
        }

        return ListTile(
          leading: Image.network(fotoS, width: 45,),
          title: Text(doctor.doctor),
          onTap: (){
            this.close(context, doctor);
          },
        );
      },
    );

    }   
  }
  
}

