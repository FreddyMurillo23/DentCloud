import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/pacient_follows_model.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/services/userPatients_service.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/list_Patients.dart';
import 'package:provider/provider.dart';

class ListPatientsBuild extends StatefulWidget {
  ListPatientsBuild({Key key}) : super(key: key);

  @override
  _ListPatientsBuildState createState() => _ListPatientsBuildState();
}

class _ListPatientsBuildState extends State<ListPatientsBuild> {
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  DataProvider1 patient = new DataProvider1();
  Future<List<PacientesSeguido>> lista;
  _getlista(String email) {
    setState(() {
      lista = patient.getPacienteSeguido(email);
    });
  }

  initState() {
    String correo = prefs.currentCorreo;
    super.initState();
    _getlista(correo);
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(screenSize),
      body: bodyLista(screenSize),
    );
  }

  Widget bodyLista(Size screenSize) {
    return FutureBuilder(
        future: lista,
        builder: (BuildContext context,AsyncSnapshot<List<PacientesSeguido>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      ListTile(
                        leading: CircleAvatar(
                         backgroundColor: Colors.transparent,
                          child: CircleAvatar(
                           radius: 50,
                          backgroundImage: NetworkImage(snapshot.data[index].fotoPaciente),
                          
                             )
                        ),
                        title: Text(snapshot.data[index].nombrePaciente),
                        subtitle:
                            Text('${snapshot.data[index].correoPaciente}\n ${snapshot.data[index].getTimeHour()}\n ${snapshot.data[index].celularPaciente}'),
                        trailing: FlatButton(
                          onPressed: () {
                            mostrar(snapshot.data[index].correoPaciente);
                          },
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.deepPurpleAccent[200],
                        ),
                        onTap: () {
                          mostrar(snapshot.data[index].correoPaciente);
                        },
                      ),
                      Divider()
                    ],
                  );
                });
          }
           return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
          );

        });
  }

  Future mostrar(String eliminado){
       return showDialog(
               context: context,
               builder: (_)=>
                  AlertDialog(
                  content: Builder(
                    builder: (context){
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return Container(
                            height: height*0.02,
                            width: width*0.45,
                            child: Text('Desea Eliminar el paciente',
                            //style: TextStyle(fontSize: 10),
                            ),
                            //color: Colors.green,
                      );
                    },
                  ),
                  title: Text("Eliminar Paciente",
                   style: TextStyle(fontSize: 20)
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: ()  {
                        Navigator.of(context).pop();
                      },
                      
                    ),
                    TextButton(
                       child: Text('Aceptar'),
                      onPressed: (){
                        setState(() {
                           patient.deletePacienteSeguido(prefs.currentCorreo, eliminado);
                           lista = patient.getPacienteSeguido(prefs.currentCorreo);
                                });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
        );
  }

  Widget appMenu(Size _screenSize) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,
    );
  }
}
