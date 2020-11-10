import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        actions: [
          FloatingActionButton(
            onPressed: (){
              print(path);
            },
            child: Icon(Icons.upload_file),
          )
        ],
      ),
      path:path,
    );
  }
}
