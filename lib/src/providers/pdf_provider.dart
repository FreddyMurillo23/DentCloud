import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/controllers/PDFcita_ctrl.dart';
import 'package:muro_dentcloud/src/models/pdf_apointments_model.dart';

class PDFProvider with ChangeNotifier{
  List<PDFModelApointment> pdf = List<PDFModelApointment>();

  void listarRecetas(String idCita){
    PDFCitaCtrl.listarPDF(idCita).then((value){
      if(value!=null){
        this.pdf = value;
      } else{
        this.pdf = List<PDFModelApointment>();
      }
      notifyListeners();
    });
  }
}