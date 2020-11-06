import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/drougs_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/receta_model.dart';
import 'package:muro_dentcloud/src/pages/medicinas/PdfPreviewScreen.dart';
import 'package:muro_dentcloud/src/pages/medicinas/recipe_test.dart';
import 'package:muro_dentcloud/src/search/search_drougs.dart';
import 'package:flutter/cupertino.dart';

class RecetaMedica2 extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;

  const RecetaMedica2({Key key, this.eventosModeloGlobal, this.currentuser}) : super(key: key);
  
  @override
  _RecetaMedica2State createState() => _RecetaMedica2State();
}

String imprimirEdad(DateTime fechaCumple){
  String edad;
  var hoy = new DateTime.now();
  var anios = hoy.year - fechaCumple.year;
  if(hoy.month <= fechaCumple.month){
    print(anios - 1);
    edad = (anios - 1).toString();
    return edad;
  }else{
    print(anios);
    edad = (anios).toString();
    return edad;
  }
}

List<TableRow> getTable(List<Receta> receta){
  List<TableRow> tableRows = List<TableRow>();
  receta.forEach((e) { 
    tableRows.add(
       TableRow(
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
            ),
          ),
        children: [
          Text(e.medicina),
          IconButton(
            icon: Icon(Icons.delete), 
            onPressed: (){
              print("Aqui se eliminaria la weada");
            }
          )
          
        ]
      )
    );
  });
  return tableRows;
}

class _RecetaMedica2State extends State<RecetaMedica2> {
  final formkey = new GlobalKey<FormState>();
  TextEditingController controladorMedicina = TextEditingController();
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorFechaUser = TextEditingController();
  TextEditingController controladorEdadUser = TextEditingController();
  
  Medicamento medicamento;
  List<Receta> recetaLista;
  Receta receta;
  String prescripcion;

  String fecha(){
    return widget.eventosModeloGlobal.fecha.year.toString()+'/'+widget.eventosModeloGlobal.fecha.month.toString()+'/'+widget.eventosModeloGlobal.fecha.day.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controladorNombreUser.text = widget.eventosModeloGlobal.paciente;
    controladorFechaUser.text = fecha();
    controladorEdadUser.text = '∞';
    controladorMedicina.text = '';
    recetaLista = [];
    medicamento = null;
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

    void validateFields(Medicamento medicamento, String prescripcion){
      final form = formkey.currentState;
      Receta receta = new Receta();

      if(form.validate()){
        form.save();
        Medicamento prueba = medicamento;
        receta.dosificacion = prueba.drugKindOfProduct;
        receta.medicina = prueba.drugName;
        receta.prescripcion = prescripcion;
        receta.presentacion = prueba.drugPharmaceuticalForm;
        setState(() {
          recetaLista.add(receta);
        });
        print("Form is valid");
      } else {
        print("Form is invalid");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: PageView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          //Ventana Principal de Receta
          SingleChildScrollView(
            child: Container(
            
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
                                            image: NetworkImage(widget.currentuser.fotoPerfil),
                                            fit: BoxFit.fill
                                          ),
                                          color: Colors.amber
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            contenedor(30, widget.currentuser.nombres+' '+widget.currentuser.nombres),
                                            SizedBox(height: 5,),
                                            contenedor(30, widget.currentuser.profesion),
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
                                        child: contenedor(30, 'CI: '+widget.currentuser.cedula),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: contenedor(30, 'Celular: '+widget.currentuser.celular),
                                      )
                                    ],
                                  ),

                                  SizedBox(height: 10,),
                                  contenedor(30, widget.currentuser.provinciaResidencia+' - '+widget.currentuser.ciudadResidencia),
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
                                            labelText: "Fecha de la Cita",
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
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => RecipeTest(
                                                    eventosModeloGlobal: widget.eventosModeloGlobal, currentuser: widget.currentuser,)));
                                        },
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
                          child: new TextFormField(
                            focusNode: FocusNode(),
                            controller: controladorMedicina,
                            readOnly: true,
                            enableInteractiveSelection: false,
                            initialValue: null,
                            decoration: InputDecoration(
                              labelText: "Medicina",
                              filled: true,
                              fillColor: Colors.white,
                              hintText: null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: ()async{
                                final seleccionMedicina = await showSearch(context: context, delegate:DrougSearchSelect());
                                if(seleccionMedicina == null) {
                                  setState(() {
                                    controladorMedicina.text = '';
                                  });
                                } else {
                                setState(() {
                                  medicamento = seleccionMedicina;
                                  controladorMedicina.text = medicamento.drugName;
                                  print(medicamento.drugAdministration);
                                });  
                                }       
                              },
                                child: Icon(Icons.search),
                              )
                            ),
                            validator: (value) => value.isEmpty ? 'Este campo no puede estar vacio' : null,
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
                                  //width: MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white
                                  ),
                                  child: medicamento == null
                                  ? Center(child: Text(''),) 
                                  : Center(child: Text(medicamento.drugKindOfProduct),),
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
                                  child: medicamento == null
                                  ? Center(child: Text(''),) 
                                  : Center(child: Text(medicamento.drugPharmaceuticalForm),),
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
                              minLines: 1,
                              expands: false,
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
                              onSaved: (value) => prescripcion = value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                
                              },
                              child: Text('Cancelar'),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                validateFields(medicamento, prescripcion);
                              },
                              child: Text('Añadir'),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                  ),
                ),
                
            ],
        ),
            ),
          ),
          
          if(recetaLista.isNotEmpty || recetaLista == null) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FixedColumnWidth(40),
                        },
                        children: getTable(recetaLista),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ]
        ],
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