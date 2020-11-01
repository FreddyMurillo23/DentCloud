import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:muro_dentcloud/src/models/apointments_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'PdfPreviewScreen.dart';

class RecipeTest extends StatefulWidget {

  final EventosModelo eventosModeloGlobal;
  final CurrentUsuario currentuser;

  const RecipeTest({Key key, this.eventosModeloGlobal, this.currentuser}) : super(key: key);
  
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
                  pw.Text(widget.currentuser.tipoUsuario,
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

                  pw.Row(
                    children: <pw.Widget>[
                      pw.Text('Nombre del Paciente: '+widget.eventosModeloGlobal.paciente,
                      textScaleFactor: 1.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                      ),
                      pw.SizedBox(width: 10),
                      
                      pw.Text('Fecha de la Cita: '+fechaCompleta(widget.eventosModeloGlobal),
                      textScaleFactor: 1.2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                      ),
                    ]
                  ),
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
    print(widget.eventosModeloGlobal.correo);
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
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}