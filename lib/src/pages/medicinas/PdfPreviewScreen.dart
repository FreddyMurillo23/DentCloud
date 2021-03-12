import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/models/event_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;
  final CurrentUsuario currentUsuario;
  final EventosModelo eventosModeloGlobal;

  PdfPreviewScreen({this.path, this.currentUsuario, this.eventosModeloGlobal});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  PDFDocument document;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }

  void loadDocument()async{
    File file = File(widget.path);
    document = await PDFDocument.fromFile(file).whenComplete((){
      setState(() {
        
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    print(widget.path);
    
    Future uploadFile(CurrentUsuario currentUsuario, EventosModelo eventosModeloGlobal) async {
      String idcita = eventosModeloGlobal.idcita;
      String descripcion = "Documento";
      String tipo = "pdf";
      DateTime fecha = DateTime.now();
      String correo = currentUsuario.correo;

      final uri =
          Uri.parse("http://54.197.83.249/PHP_REST_API/api/post/post_documents.php?appointment_id=$idcita&document_description=$descripcion&document_type=$tipo&document_date=$fecha&user_email_doctor=$correo");
      var request = http.MultipartRequest('POST', uri);
      request.fields['usuario'] = currentUsuario.correo;
      var pic = await http.MultipartFile.fromPath("archivo", widget.path);
      request.files.add(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        print('ARCHIVO SUBIDA');
      } else {
        print('ARCHIVO NO SUBIDA');
      }
  }
  
    return Scaffold(
      appBar: AppBar(),
      body: document != null
      ? PDFViewer(document: document, zoomSteps: 1,)
      : Center(child: CircularProgressIndicator()),

      
    );
  }
}
