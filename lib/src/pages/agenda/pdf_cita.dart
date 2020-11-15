import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/PDFcita_ctrl.dart';
import 'package:muro_dentcloud/src/models/pdf_apointments_model.dart';

class PDFCitas extends StatefulWidget {


  @override
  _PDFCitasState createState() => _PDFCitasState();
  
}

class _PDFCitasState extends State<PDFCitas> {

  PDFModelApointment pdfModel;
  PDFCitaCtrl pdfCtrol;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Recetas", style: TextStyle(color: Colors.black, fontSize: 35),),
        centerTitle: true,
      ),
    );
  }
  
}