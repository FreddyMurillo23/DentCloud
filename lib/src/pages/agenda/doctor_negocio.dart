import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/doctors_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/models/negocios_model.dart';

class DoctorNegocio extends StatefulWidget {
  final NegociosSearch negociosSearch;

  const DoctorNegocio({Key key, this.negociosSearch}) : super(key: key);

  @override
  _DoctorNegocioState createState() => _DoctorNegocioState();
}

class _DoctorNegocioState extends State<DoctorNegocio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: DoctorCtrl.listarDoctoresNegocio(widget.negociosSearch.rucnegocio),
        builder: (BuildContext context, AsyncSnapshot<List<DoctoresNegocio>> snapshot) {
          if(snapshot.hasData) {
            final doctores = snapshot.data;
            return ListView(
              children: doctores.map((doctores) {
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
                                image: NetworkImage(doctores.fotoperfil)
                              )
                            ),
                          ),
                          title: Text(doctores.nombredoctor),
                          subtitle: Text(doctores.profesiondoctor),
                          onTap: (){
                            Navigator.pop(context,doctores);
                          },
                        ),
                      ),
                      Divider(),
                  ],
                );
              }).toList(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}