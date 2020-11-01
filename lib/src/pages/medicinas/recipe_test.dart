import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class RecipeTest extends StatefulWidget {

  
  @override
  _RecipeTestState createState() => _RecipeTestState();
}

documentoCrear(pw.Document doc){
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  file.writeAsBytesSync(doc.save());
}

class _RecipeTestState extends State<RecipeTest> {
  final doc = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: (){
                documentoCrear(doc);
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}