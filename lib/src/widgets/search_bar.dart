
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/doctors_ctrl.dart';
import 'package:muro_dentcloud/src/controllers/negocios_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/negocios_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/doctor_negocio.dart';
import 'package:muro_dentcloud/src/providers/services_provider.dart';
import 'package:provider/provider.dart';

class EventSearchDelegate extends SearchDelegate<DoctoresNegocio>{

  @override
  final String searchFieldLabel;
  final List<Doctores> historial;
  String seleccion = " ";

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
          DoctoresNegocio docsNegocio = DoctoresNegocio(
            ceduladoctor: '',
            celulardoctor: '',
            correodoctor: '',
            fotoperfil: '',
            nombredoctor: '',
            profesiondoctor: '',
            roldoctor: '',
            sexodoctor: ''
          );
          Doctores docs = Doctores(cedula: "", correo: "", celular: "", doctor: "", fechanacimiento: DateTime.now(), foto: "");
          print(docs.cedula);
          this.close(context, docsNegocio);
        },
      );
    }
  

    @override
    Widget buildResults(BuildContext context) {
      return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
      
    }
  

    @override
    Widget buildSuggestions(BuildContext context) {
      if (query.isEmpty) {
        return Container(
        );
      }
      return FutureBuilder(
        future: NegociosCtrl.listarNegocios(query),
        builder: (BuildContext context, AsyncSnapshot<List<NegociosSearch>> snapshot) {
          if(snapshot.hasData) {
            final negocios = snapshot.data;
            return ListView(
              children: negocios.map((negocio) {
                return Column(
                  children: [
                    Card(
                        margin: new EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 5,
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(negocio.fotonegocio)
                              )
                            ),
                          ),
                          title: Text(negocio.nombrenegocio),
                          subtitle: Text(negocio.provincia),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute<DoctoresNegocio>(
                                  builder: (_) => DoctorNegocio(negociosSearch: negocio,
                                      ))).then((value) => print(value.ceduladoctor));
                            // this.close(context, null);
                            //print(doctorInfo.ceduladoctor);
                          },
                        ),
                      ),
                      Divider(),
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.white30,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(2.0, 10.0))
                      ]),
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
      );
  }
  
}

