import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/route_argument.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/services/serviceData_service.dart';
import 'package:muro_dentcloud/src/widgets/ServiceWg.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class BusinessDoctorServices extends StatefulWidget {
  RouteArgument routeArgument;
  BusinessDoctorServices({Key key, this.routeArgument}) : super(key: key);

  @override
  _BusinessDoctorServicesState createState() => _BusinessDoctorServicesState();
}

class _BusinessDoctorServicesState extends State<BusinessDoctorServices> {
  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();
    bool activar;
    final screenSize = MediaQuery.of(context).size;
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
          // floa ting: true,
          // actions: [
          //   CircleButton(
          //     icon: MdiIcons.leadPencil,
          //     iconsize: 30.0,
          //     colorIcon: Colors.blue[600],
          //     colorBorde: Colors.lightBlue[50],
          //     onPressed: () {
          //       if (activar == true) {
          //       } else {
          //         print('No hay datos ');
          //       }
          //     },
          //   )
          // ],
        ),
        body: _swiperServ(widget.routeArgument.list, screenSize));
  }

  Widget _swiperServ(List<Personal> personal, Size _screeSize) {
    print(personal.length);
    print('Helllooooo');
    if (personal.length > 0) {
      return Swiper(
        itemWidth: _screeSize.width,
        itemHeight: _screeSize.height * 0.90,
        itemCount: personal.length,
        viewportFraction: 0.85,
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          print(_screeSize.height);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: _screeSize.height * 0.80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(40),
                            top: Radius.circular(40)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              // color: Colors.grey[500],
                              color: Colors.lightBlue,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0))
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                          top: Radius.circular(40)),
                      child: Center(
                        child: Padding(
                          // centerTitle: true,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(80),
                                    top: Radius.circular(80)),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(40),
                                        top: Radius.circular(40)),
                                    child: Image(
                                      image: AssetImage('assets/fondo.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: section1(
                                        _screeSize, context, personal[index]),
                                  )
                                ],
                              )
                              //
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(child: ServiceDataWg(services[index])),
            ],
          );
        },
        //pagination: new SwiperPagination(),
        control: new SwiperControl(),
        //layout: SwiperLayout.CUSTOM,
      );
    } else {
      return Center(child: Text('No hay medicos registrados',style: TextStyle(fontSize: 20),));
    }
  }

  Widget section1(Size screensize, context, Personal personal) {
    return Padding(
      padding: EdgeInsets.only(
          top: screensize.height * 0.020,
          left: screensize.width * 0.04,
          right: screensize.width * 0.04,
          bottom: 10),
      child: Center(
        child: Column(
          children: [profileData(screensize, context, personal)],
        ),
      ),
    );
  }

  profileData(Size screensize, context, Personal personal) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        width: screensize.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: screensize.height * 0.35,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 5, color: Colors.lightBlue.shade300),
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: FadeInImage(
                    image: NetworkImage(personal.fotoPerfil),
                    placeholder: AssetImage('assets/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              SizedBox(
                height: screensize.height * 0.015,
              ),
              Text('${personal.nombreDoctor}',
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Text(
                '\nProfesion: \n${personal.profesionDoctor}',
                textAlign: TextAlign.center,
              ),
              Text(
                '\nCorreo: \n${personal.correoDoctor}',
                textAlign: TextAlign.center,
              ),
              Text('\nTelefono: \n${personal.celularDoctor}\n',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
