import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';

class RecetaMedica extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;

  const RecetaMedica({Key key, this.eventosModeloGlobal}) : super(key: key);
  
  @override
  _RecetaMedicaState createState() => _RecetaMedicaState();
}



class _RecetaMedicaState extends State<RecetaMedica> {
  final formkey = new GlobalKey<FormState>();
  TextEditingController controlador = TextEditingController();
  TextEditingController controladorCorreoUser = TextEditingController();
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorApellidoUser = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controladorCorreoUser.text = '';
    controladorNombreUser.text = '';
    controladorApellidoUser.text = '';
  }

  Widget contenedor(double altura, double ancho, String texto, Color color){
      return Container(
        height: altura,
        width: ancho,
        child: Text(texto),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: color
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(   
            
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,       
            children: [

              Text("Receta Medica", style: TextStyle(color: Colors.black, fontSize: 35),),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[900],
                                borderRadius: BorderRadius.all(Radius.circular(20)),            
                              ),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Column(                 
                                children: [
                                  
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [   
                                      contenedor(50, 100, 'Prueba', Colors.amber),       
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                    ],
                  )
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}