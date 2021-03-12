import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:muro_dentcloud/src/controllers/PDFService_ctrl.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PDFCitas extends StatefulWidget {

  final String idCita;
  final String url;

  const PDFCitas({Key key, this.idCita, this.url}) : super(key: key);

  @override
  _PDFCitasState createState() => _PDFCitasState();
}

class _PDFCitasState extends State<PDFCitas> {
  String localPath;
  PDFDocument document;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.url);
    obtainPDF();

    ApiServiceProvider.loadPDF(widget.url).then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  void obtainPDF()async{
    document = await PDFDocument.fromURL(
      widget.url).whenComplete(() {
        setState(() {
          
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: document != null
          ? PDFViewer(
              document: document,
              zoomSteps: 1,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
