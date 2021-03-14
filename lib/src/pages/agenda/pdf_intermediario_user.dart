import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/pdf_apointments_model.dart';
import 'package:muro_dentcloud/src/pages/agenda/pdf_cita.dart';
import 'package:muro_dentcloud/src/providers/pdf_provider.dart';
import 'package:provider/provider.dart';

class VistaPDFUser extends StatefulWidget {

  final String idCita;

  const VistaPDFUser({Key key, this.idCita}) : super(key: key);

  @override
  _VistaPDFUserState createState() => _VistaPDFUserState();
}

int count = 2;


class _VistaPDFUserState extends State<VistaPDFUser> {
  PDFProviderPatientsCita pdfProvider;

  @override
  Widget build(BuildContext context) {
    pdfProvider = Provider.of<PDFProviderPatientsCita>(context);
    pdfProvider.listarRecetasPacientesCita(widget.idCita);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Selector<PDFProviderPatientsCita, List<PDFModelApointment>>(
        selector: (context, model) => model.pdf,
        builder: (context, value, child) => 
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisCount: 2,
            children: List<Widget>.generate(
              value.length, 
              (index) {
                return GridTile(
                  footer: Center(child: Text(value[index].fechaCarga.toIso8601String()),),
                  child: GestureDetector(
                    child: Card(
                      child: Image.asset('assets/pdf.png', fit: BoxFit.fill,),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PDFCitas(idCita: widget.idCita, url: value[index].url,)));
                    },
                  ),
                );
              }
            ),
          ),
        )
        
      ),
    );
  }
}