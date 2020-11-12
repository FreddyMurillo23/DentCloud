
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/drougs_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/receta_model.dart';
import 'package:muro_dentcloud/src/pages/medicinas/recipe_test.dart';
import 'package:muro_dentcloud/src/search/search_drougs.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RecetaMedica extends StatefulWidget {
  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;

  const RecetaMedica({Key key, this.eventosModeloGlobal, this.currentuser}) : super(key: key);
  
  @override
  _RecetaMedicaState createState() => _RecetaMedicaState();
}

String genero(CurrentUsuario userinfo){
  if(userinfo.sexo == 'M') {
    return 'Dr. ';
  } else {
    return 'Dra. ';
  }
}

List<pw.TableRow> getTableRow(List<Receta> receta){
  List<pw.TableRow> tableRows = List<pw.TableRow>();
  receta.forEach((element) { 
    print(receta.length);
    tableRows.add(
       pw.TableRow(
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text('Medicamento: '+element.medicina),
              pw.Text('Dosificacion: '+element.dosificacion, style: pw.TextStyle(fontSize: 10)),
              pw.Text('Presentacion: '+element.presentacion, style: pw.TextStyle(fontSize: 10)),
              pw.Text('Prescripcion: '+element.prescripcion, style: pw.TextStyle(fontSize: 10)),
              pw.Divider(),
            ]
          )
        ]
      )
    );
  });
  return tableRows;
}

String fechaCompleta(EventosModelo eventos) {
  return eventos.fecha.year.toString()+'-'+eventos.fecha.month.toString()+'-'+eventos.fecha.day.toString();
}

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);

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



class _RecetaMedicaState extends State<RecetaMedica> {
  final formkey = new GlobalKey<FormState>();
  TextEditingController controladorMedicina = TextEditingController();
  TextEditingController controladorNombreUser = TextEditingController();
  TextEditingController controladorFechaUser = TextEditingController();
  TextEditingController controladorEdadUser = TextEditingController();
  TextEditingController controladorDosifiacion = TextEditingController();
  TextEditingController controladorPresentacion = TextEditingController();
  
  Medicamento medicamento;
  List<Receta> recetaLista;
  Receta receta;
  String prescripcion = '';

  String fecha(){
    return widget.eventosModeloGlobal.fecha.year.toString()+'/'+widget.eventosModeloGlobal.fecha.month.toString()+'/'+widget.eventosModeloGlobal.fecha.day.toString();
  }

  final pdf = pw.Document();

  //Cupertino Dialog
    Future<void> cupertinoDialog(BuildContext context) async {
      switch (await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Generar Receta'),
            content: Text('¿Desea generar la receta?, una vez generada no podrá modificarse'),
            actions: <Widget>[
              DialogButton(
                child: const Text('Aceptar', style: TextStyle(color: Colors.lightBlue),), 
                onPressed: (){
                  Navigator.pop(context, 'Aceptar');
                },
                color: Colors.white
              ),
              DialogButton(
                child: const Text('Cancelar', style: TextStyle(color: Colors.lightBlue),), 
                onPressed: (){
                  Navigator.pop(context, 'Cancelar');
                },
                color: Colors.white
              ),
            ],
          );
        },
      )) {
        case 'Aceptar':
          print('Aceptar');
          String archivo = widget.eventosModeloGlobal.nombrePaciente;

          writeOnPdf();
          await savePdf();

          Directory documentDirectory = await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/recipe2_$archivo.pdf";
          print(fullPath);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                child: new Container(
                  height: 100,
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new CircularProgressIndicator(),
                      new SizedBox(width: 10,),
                      new Text(" Generando Documento"),
                    ],
                  ),
                ),
              );
            },
          );

          new Future.delayed(new Duration(milliseconds: 1500), () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => PdfPreviewScreen(path: fullPath, currentUsuario: widget.currentuser, eventosModeloGlobal: widget.eventosModeloGlobal,)
            ));
          
          });
          break;
        case 'Cancelar':
          print('Cancelar');

          break;
      }
    }

  writeOnPdf(){
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),

        build: (pw.Context context) =>[
          pw.Expanded(
            child: pw.Partitions(children: [
            pw.Partition(
              child: pw.Column(
                children: <pw.Widget>[
                  pw.Text(genero(widget.currentuser)+widget.currentuser.nombres+' '+widget.currentuser.apellidos,
                    textScaleFactor: 2,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                  pw.Text(widget.currentuser.profesion,
                      textScaleFactor: 1.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                  ),
                  pw.Text('Cedula: '+widget.currentuser.cedula,
                      textScaleFactor: 1.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                  ),
                  pw.Text('Correo Profesional: '+widget.currentuser.correo,
                      textScaleFactor: 1.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                  ),
                  
                  pw.Divider(),

                  pw.Partitions(children: [
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Nombre del Paciente: '+widget.eventosModeloGlobal.paciente,
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                          ),
                        ]
                      )
                    ),
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                         pw.Text('Fecha de la Cita: '+fechaCompleta(widget.eventosModeloGlobal),
                        textScaleFactor: 1.2,
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                        ),
                        ]
                      )
                    )
                  ]),

                  pw.Partitions(children: [
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Servicio: '+widget.eventosModeloGlobal.servicio,
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                          ),
                        ]
                      )
                    ),
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                         pw.Text('Edad: '+imprimirEdad(widget.eventosModeloGlobal.fechaNacimiento),
                        textScaleFactor: 1.2,
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                        ),
                        ]
                      )
                    ),
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Aqui va algo: '+widget.eventosModeloGlobal.paciente,
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                          ),
                        ]
                      )
                    ),
                  ]),

                  pw.SizedBox(height: 10),

                  pw.Table(
                    defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: pw.FlexColumnWidth(1),
                    },
                    children: getTableRow(recetaLista) 
                  ),

                  pw.SizedBox(height: 50),
                  pw.Footer(

                    title: pw.Text('Aqui podria ir la firma del Dcotor')
                  )
                ]
              ),
            ),
          ])
          ),
        ]

      )
    );
  }

  Future savePdf() async{
    String archivo = widget.eventosModeloGlobal.nombrePaciente;
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/recipe2_$archivo.pdf");
    //File file = File("/storage/emulated/0/Android/data/example.pdf");

    file.writeAsBytesSync(pdf.save(), mode: FileMode.append);
  }

  @override
  void initState() {
    super.initState();
    controladorNombreUser.text = widget.eventosModeloGlobal.paciente;
    controladorFechaUser.text = fecha();
    controladorEdadUser.text = imprimirEdad(widget.eventosModeloGlobal.fechaNacimiento);
    controladorMedicina.text = '';
    controladorDosifiacion.text = '';
    controladorPresentacion.text = '';
    recetaLista = [];
    medicamento = null;
  }

  void reset(){
    controladorMedicina.text = '';
    controladorDosifiacion.text = '';
    controladorPresentacion.text = '';
  }

  List<TableRow> getTable(List<Receta> receta, String prescripcion, BuildContext context){
  List<TableRow> tableRows = List<TableRow>();
  receta.forEach((e) { 
    tableRows.add(
       TableRow(
        children: [
          Card(
            child: ExpansionTile(
              title: Text(e.medicina),
              children: [
                ListTile(
                  title: Text('Dosificacion: '+e.dosificacion),
                  subtitle: Text('Prescripcion: '+prescripcion),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red,), 
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Eliminar Elemento'),
                    content: const Text('¿Está seguro que desea cancelar este elemento?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: (){
                          setState(() {
                            receta.remove(e);
                          });
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('Aceptar'),
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            }
          )
          
        ]
      )
    );
  });
  return tableRows;
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

    void validateFields(Medicamento medicamento, String prescripcion, BuildContext context){
      final form = formkey.currentState;
      Receta receta = new Receta();

      if(form.validate()){
        form.save();
        Medicamento prueba = medicamento;
        String prescri = prescripcion;
        receta.dosificacion = prueba.drugKindOfProduct;
        receta.medicina = prueba.drugName;
        receta.prescripcion = prescri;
        receta.presentacion = prueba.drugPharmaceuticalForm;
        setState(() {
          recetaLista.add(receta);
        });
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se registro la medicina"), duration: Duration(seconds: 1), backgroundColor: Colors.green,));
        print("Form is valid");
      } else {
        print("Form is invalid");
      }
    }

    return GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },

        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Builder(
          builder: (context) => PageView(
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
                                              validateFields(medicamento, prescripcion, context);
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
                                      controladorDosifiacion.text = medicamento.drugKindOfProduct;
                                      controladorPresentacion.text = medicamento.drugPharmaceuticalForm;
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
                                    TextFormField(
                                      controller: controladorDosifiacion,
                                      minLines: 1,
                                      readOnly: true,
                                      decoration: InputDecoration(                           
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabled: true,
                                        hintText: null,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                      ),
                                    ),
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
                                    TextFormField(
                                      autofocus: false,
                                      controller: controladorPresentacion,
                                      minLines: 1,
                                      readOnly: true,
                                      decoration: InputDecoration(                           
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabled: true,
                                        hintText: null,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                      ),
                                    ),
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
                                  textCapitalization: TextCapitalization.sentences,
                                  autofocus: false,
                                  
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
                                  onChanged: (value) {
                                    setState(() {
                                      prescripcion = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          //Row de Botones
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text('Cancelar'),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () async {
                                    if(recetaLista == [] || recetaLista == null || recetaLista.length == 0){
                                      showDialog(
                                      context: context,
                                      builder: (_) => new AlertDialog(
                                          title: new Text("No se pudo generar la receta"),
                                          content: new Text("Deben existir elementos para poder generar la receta"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Aceptar'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        )
                                      );
                                    } else {

                                      cupertinoDialog(context);

                                      // String archivo = widget.eventosModeloGlobal.nombrePaciente;

                                      // writeOnPdf();
                                      // await savePdf();

                                      // Directory documentDirectory = await getApplicationDocumentsDirectory();

                                      // String documentPath = documentDirectory.path;

                                      // String fullPath = "$documentPath/recipe2_$archivo.pdf";
                                      // print(fullPath);

                                      // ruta = fullPath;

                                      // showDialog(
                                      //   context: context,
                                      //   barrierDismissible: false,
                                      //   builder: (BuildContext context) {
                                      //     return Dialog(
                                      //       child: new Container(
                                      //         height: 100,
                                      //         child: new Row(
                                      //           mainAxisSize: MainAxisSize.min,
                                      //           children: [
                                      //             new CircularProgressIndicator(),
                                      //             new SizedBox(width: 10,),
                                      //             new Text(" Generando Documento"),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // );

                                      // new Future.delayed(new Duration(milliseconds: 1500), () {
                                      //   Navigator.of(context).pop();
                                      //   Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) => PdfPreviewScreen(path: ruta, currentUsuario: widget.currentuser, eventosModeloGlobal: widget.eventosModeloGlobal,)
                                      //   ));
                                      
                                      // });

                                    }
                                  },
                                  color: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text('Generar Receta'),
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
                            children: getTable(recetaLista, prescripcion, context),
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