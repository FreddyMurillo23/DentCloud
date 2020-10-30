import 'dart:ffi';

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
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorFechaUser = TextEditingController();
  TextEditingController controladorEdadUser = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controladorNombreUser.text = 'Aqui va el Nombre del Paciente';
    controladorFechaUser.text = 'YYYY/MM/DD';
    controladorEdadUser.text = 'NN';
  }

  Widget contenedor(double altura, String texto){
      return Container(
        height: altura,
        decoration: BoxDecoration(
          color: Colors.blueGrey[600],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(child: Text(texto, style: TextStyle(color: Colors.white),),),
      );
    }

    Widget textFields(String texto, TextEditingController controller){
      return Flexible(
        child: TextField(
          controller: controladorNombreUser,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            
            filled: true,
            fillColor: Colors.blueGrey[600],
            labelText: texto,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white
            ),
            enabled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ),
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Receta Medica", style: TextStyle(color: Colors.black, fontSize: 35),),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.fill
            ),
          ),
          child: Column(   
            
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,       
            children: [

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
                              height: 350,
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
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage("http://54.197.83.249/Contenido_ftp/Imagenes%20por%20defecto/Placeholder_male.png"),
                                            fit: BoxFit.fill
                                          ),
                                          color: Colors.amber
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            contenedor(30, "Aqui va el nombre"),
                                            SizedBox(height: 5,),
                                            contenedor(30, "Aqui va la profesion"),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: contenedor(30, "Aqui va el CI"),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: contenedor(30, "Aqui va el telefono"),
                                      )
                                    ],
                                  ),

                                  SizedBox(height: 10,),
                                  contenedor(30, "Aqui va la direccion"),
                                  SizedBox(height: 15,),
                                  textFields('Nombre del Paciente', controladorNombreUser),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          controller: controladorFechaUser,
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.blueGrey[600],
                                            labelText: "Fecha",
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            enabled: false,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: TextField(
                                          controller: controladorEdadUser,
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.blueGrey[600],
                                            labelText: "Edad",
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            enabled: false,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      FloatingActionButton(
                                        onPressed: (){},
                                        child: Icon(Icons.add_circle),
                                        elevation: 0,
                                        backgroundColor: Colors.blueGrey[900],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      //Primer Row - Medicamentos y Denominacion
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text('Medicamento:', style: TextStyle(color: Colors.black),),
                                SizedBox(height: 5,),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: [], 
                                      onChanged: null,
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              ClipPath(
                                child: Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                clipper: CustomClipPathPrueba(),
                              ),
                            ],
                          ),

                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [
                                Text('Denomiacion Generica:', style: TextStyle(color: Colors.black),),
                                SizedBox(height: 5,),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white
                                  ),
                                  child: Text(''),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      //Segundo Row - Dosificacion y Presentacion
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text('Dosificacion:', style: TextStyle(color: Colors.black),),
                                SizedBox(height: 5,),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: [], 
                                      onChanged: null,
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                          
                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [
                                Text('Presentacion:', style: TextStyle(color: Colors.black),),
                                SizedBox(height: 5,),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white
                                  ),
                                  child: Text(''),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      //Row de Prescripcion
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: new TextFormField(
                              maxLines: 3,
                              decoration: InputDecoration(   
                                labelText: "Prescripcion",                         
                                filled: true,
                                fillColor: Colors.white,
                                enabled: true,
                                hintText: null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
                              onTap: () {
                              },
                            ),
                          ),
                        ],
                      ),
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

class CustomClipPathPrueba extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.width);
    path.lineTo(size.height, size.width/2);
    path.close();
    return path;  
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}