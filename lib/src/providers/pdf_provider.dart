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

class PDFProviderPatients with ChangeNotifier{
  List<PDFModelApointment> pdf = List<PDFModelApointment>();

  void listarRecetasPacientes(String email){
    PDFCitaCtrl.listarPDFPatients(email).then((value){
      if(value!=null){
        this.pdf = value;
      } else{
        this.pdf = List<PDFModelApointment>();
      }
      notifyListeners();
    });
  }
}

//PDF Provider para repositorio de Usuarios
class PDFProviderByUser with ChangeNotifier{
  List<PDFModelApointmentUser> pdf = List<PDFModelApointmentUser>();

  void listarRecetasPacientes(String email){
    PDFCitaCtrl.listarPDFRepositoryPatients(email).then((value){
      if(value!=null){
        this.pdf = value;
      } else{
        this.pdf = List<PDFModelApointmentUser>();
      }
      notifyListeners();
    });
  }
}

class PDFProviderPatientsCita with ChangeNotifier{
  List<PDFModelApointment> pdf = List<PDFModelApointment>();

  void listarRecetasPacientesCita(String idCita){
    PDFCitaCtrl.listarPDFPatientsCita(idCita).then((value){
      if(value!=null){
        this.pdf = value;
      } else{
        this.pdf = List<PDFModelApointment>();
      }
      notifyListeners();
    });
  }
}