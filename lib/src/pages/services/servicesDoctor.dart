import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/services/serviceData_service.dart';
import 'package:muro_dentcloud/src/widgets/ServiceWg.dart';
import 'package:muro_dentcloud/src/widgets/business_ServicesWg.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class DoctorServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ServiciosNegocio> servicios =
        ModalRoute.of(context).settings.arguments;
    final HttpService httpService = HttpService();
    final screenSize = MediaQuery.of(context).size;
    bool activar;
    final HttpServiceData httpService1 = HttpServiceData();
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
          actions: [
            CircleButton(
              icon: MdiIcons.leadPencil,
              iconsize: 30.0,
              colorIcon: Colors.blue[600],
              colorBorde: Colors.lightBlue[50],
              onPressed: () {
                if (activar == true) {
                } else {
                  print('No hay datos ');
                }
              },
            )
          ],
        ),
        body: _swiperServ(servicios, httpService1, screenSize));
  }

  Widget _swiperServ(List<ServiciosNegocio> services,
      HttpServiceData httpService, Size _screeSize) {
    print(services.length);
    print('Helllooooo');
    return Swiper(
      itemWidth: _screeSize.width,
      itemHeight: _screeSize.height * 0.99,
      itemCount: services.length,
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
                        services[index].imagenServicio,
                        fit: BoxFit.cover,
                      )),
                  Container(
                      padding: EdgeInsets.all(1.0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        '${services[index].servicio}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(child: ServiceDataWg(services[index])),
          ],
        );
      },
      //pagination: new SwiperPagination(),
      control: new SwiperControl(),
      //layout: SwiperLayout.CUSTOM,
    );
  }
}
