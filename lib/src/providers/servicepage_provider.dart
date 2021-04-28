import 'package:flutter/cupertino.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';

import 'data_provider.dart';

class ServiceDoctorProvider with ChangeNotifier{
  DataProvider providerservico= new DataProvider();
  List<NegocioData> datosnegocio= List<NegocioData>();

  void serviciosActual(String ruc)
  {
    providerservico.businessData(ruc).then((value) {
     if(value!=null)
     {
       this.datosnegocio=value;
     }
     else
     {
       this.datosnegocio=List<NegocioData>();
     }
    });

  }

}