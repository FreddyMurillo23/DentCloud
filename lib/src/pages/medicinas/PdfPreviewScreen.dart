import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    String prueba = '/data/user/0/easyapproach.com.pdf_test/app_flutter/weySoyYo';
    return PDFViewerScaffold(
      appBar: AppBar(),
      path:path,
    );
  }
}
