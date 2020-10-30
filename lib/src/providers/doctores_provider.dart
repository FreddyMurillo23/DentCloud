import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/controllers/doctors_ctrl.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';

class DoctoresProvider with ChangeNotifier{
  List<Doctores> doctores = List<Doctores>();

  void listarDoctores(){
    DoctorCtrl.listarDoctores().then((value){
      if(value!=null){
        this.doctores = value;
      } else{
        this.doctores = List<Doctores>();        
      }
      notifyListeners();
    });
  }
}

class DoctoresProviderName with ChangeNotifier{
  List<Doctores> doctoresName = List<Doctores>();

  void listarDoctoresName(String name){
    DoctorCtrl.listarPrueba(name).then((value){
      if(value!=null){
        this.doctoresName = value;
      } else{
        this.doctoresName = List<Doctores>();       
      }
      notifyListeners();
    });
  }
}