import 'dart:io';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:muro_dentcloud/src/models/receta_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'PdfPreviewScreen.dart';

class RecipeTest extends StatefulWidget {

  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;
  final List<Receta> receta;

  const RecipeTest({Key key, this.eventosModeloGlobal, this.currentuser, this.receta}) : super(key: key);
  
  @override
  _RecipeTestState createState() => _RecipeTestState();
}

String genero(CurrentUsuario userinfo){
  if(userinfo.sexo == 'M') {
    return 'Dr. ';
  } else {
    return 'Dra. ';
  }
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

List<pw.TableRow> getTable(List<Receta> receta){
  List<pw.TableRow> tableRows = List<pw.TableRow>();
  receta.forEach((element) { 
    tableRows.add(
       pw.TableRow(
        // decoration: pw.BoxDecoration(
        //   border: pw.BoxBorder(
        //     bottom: true,
        //     top: true,
        //     right: true,
        //     left: true,
        //     style: pw.BorderStyle.solid,
        //     color: green
        //   )
        // ),
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text('Medicamento: '+element.medicina),
              pw.Text('Dosificacion: '+element.dosificacion, style: pw.TextStyle(fontSize: 10)),
              pw.Text('Presentacion: '+element.presentacion, style: pw.TextStyle(fontSize: 10)),
              // pw.Text('Prescripcion: '+element.prescripcion, style: pw.TextStyle(fontSize: 10)),
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

class _RecipeTestState extends State<RecipeTest> {
  
  final pdf = pw.Document();

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
                    children: 
                      getTable(widget.receta),                    
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
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;
    print(documentPath);

    File file = File("$documentPath/example.pdf");
    //File file = File("/storage/emulated/0/Android/data/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  Widget build(BuildContext context) {
    print(widget.receta[0].prescripcion);
    return Scaffold(

      appBar: AppBar(
        title: Text("PDF Flutter"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("PDF TUTORIAL", style: TextStyle(fontSize: 34),)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          writeOnPdf();
          await savePdf();

          Directory documentDirectory = await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/example.pdf";
          print(fullPath);

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => PdfPreviewScreen(path: fullPath,)
          ));
        },
        child: Icon(Icons.save),
      ),

    );
  }
}
