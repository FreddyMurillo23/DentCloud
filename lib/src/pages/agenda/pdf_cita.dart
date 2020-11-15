import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:muro_dentcloud/src/controllers/PDFService_ctrl.dart';

class PDFCitas extends StatefulWidget {

  final String idCita;
  final String url;

  const PDFCitas({Key key, this.idCita, this.url}) : super(key: key);

  @override
  _PDFCitasState createState() => _PDFCitasState();
}

class _PDFCitasState extends State<PDFCitas> {
  String localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiServiceProvider.loadPDF(widget.url).then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
