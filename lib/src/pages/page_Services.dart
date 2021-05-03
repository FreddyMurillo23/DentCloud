import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/providers/servicepage_provider.dart';
import 'package:muro_dentcloud/src/widgets/ServiceWg_1.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/services/serviceData_service.dart';
import 'package:muro_dentcloud/src/widgets/ServiceWg.dart';
import 'package:muro_dentcloud/src/widgets/business_ServicesWg.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:provider/provider.dart';

class BusinessServicePage extends StatefulWidget {
  BusinessServicePage({Key key}) : super(key: key);

  @override
  _BusinessServicePageState createState() => _BusinessServicePageState();
}

class _BusinessServicePageState extends State<BusinessServicePage> {
  @override

  ServiceDoctorProvider negocio;
  DataProvider provider= new DataProvider();

  Widget build(BuildContext context) {
   final List<dynamic> objeto = ModalRoute.of(context).settings.arguments;
    final HttpService httpService = HttpService();
    final screenSize = MediaQuery.of(context).size;
    negocio=Provider.of<ServiceDoctorProvider>(context);
    negocio.serviciosActual(objeto[1]);
    if(negocio.datosnegocio.isEmpty)
    {
      setState(() {
        funcionPrueba(context, objeto);
      });

    }
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Image(
          image: AssetImage('assets/title.png'),
          height: screenSize.height * 0.1,
          fit: BoxFit.fill,
        ),
        centerTitle: false,
      ),
      body: funcionPrueba(context, objeto),
    );

  }

  funcionPrueba(BuildContext prueba,List<dynamic> objeto)
  {
    return  Selector<ServiceDoctorProvider,List<NegocioData>>(
         selector: (context,model) =>model.datosnegocio,
         builder: (context,value,child) {
          return listaservicio(value, objeto);
         });

  }

  Widget listaservicio(List<NegocioData> value,List<dynamic> objeto)
  {
    final screenSize = MediaQuery.of(context).size;
    final HttpServiceData httpService1 = HttpServiceData();
    if(value.isNotEmpty)
    {
       return Container(
            height: screenSize.height * 0.99,
            child: _swiperServ(value[0], httpService1, screenSize,objeto[1]),
         );
    }
    else{
      return Center(child: CircularProgressIndicator());
    }
  }
  Widget _swiperServ(NegocioData businessSe,HttpServiceData httpService,Size _screeSize, String businessRuc){
  // List<dynamic> objeto= new List();
  return Swiper(
        itemWidth: _screeSize.width,
        itemHeight: _screeSize.height*0.99,
        itemCount: businessSe.servicios.length,
        viewportFraction: 0.85,
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: _screeSize.height * 0.3,
                child: Stack(
                  alignment: Alignment(-0.93, 0.93),
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                              businessSe.servicios[index].imagenServicio,
                          fit: BoxFit.cover,
                        )),
                    Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          businessSe.servicios[index].servicio,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(child: ServiceDataWg1(businessSe.servicios[index],businessRuc)),
                SizedBox(height: 10),
          //     CircleButton(
          //   icon: MdiIcons.leadPencil,
          //   iconsize: 40.0,
          //    colorIcon: Colors.blue[600],
          //     colorBorde: Colors.lightBlue[50],
          //   onPressed: () {
          //     if(activar==true)
          //     { 
          //       objeto.add(businessSe[index]);
          //       objeto.add( businessRuc);
          //       Navigator.pushNamed(context, 'editPageService',arguments: objeto);
          //     }
          //     else
          //     {
          //       print('No hay datos ');
          //     }
          //   }, 
          // )
              
            ],
          );
        },
        //pagination: new SwiperPagination(),
        control: new SwiperControl(),
        //layout: SwiperLayout.CUSTOM,
  );
  }
}