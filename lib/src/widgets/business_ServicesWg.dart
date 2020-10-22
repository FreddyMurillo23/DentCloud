import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/services/serviceData_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:muro_dentcloud/src/widgets/ServiceWg.dart';

class BusinessServicesWg extends StatefulWidget {
  final List<NegocioDato> businessSe;
  const BusinessServicesWg(this.businessSe);

  @override
  _BusinessServicesWgState createState() => _BusinessServicesWgState();
}

class _BusinessServicesWgState extends State<BusinessServicesWg> {
  @override
  Widget build(BuildContext context) {
    final HttpServiceData httpService = HttpServiceData();

    final _screeSize = MediaQuery.of(context).size;
    return _swiperServ(_screeSize, httpService);
  }

  Widget _swiperServ(Size _screeSize, HttpServiceData httpService) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 15.0),
      height: _screeSize.height,
      child: Swiper(
        itemWidth: _screeSize.width,
        itemHeight: _screeSize.height,
        itemCount: this.widget.businessSe[0].servicios.length,
        viewportFraction: 0.8,
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
                          this
                              .widget
                              .businessSe[0]
                              .servicios[index]
                              .imagenServicio,
                          fit: BoxFit.cover,
                        )),
                    Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          this.widget.businessSe[0].servicios[index].servicio,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: _screeSize.height * 0.5,
                child: FutureBuilder(
                  future: httpService.getServices(
                      this.widget.businessSe[0].servicios[index].idServicio),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ServiceDataWg(snapshot.data);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          );
        },
        //pagination: new SwiperPagination(),
        control: new SwiperControl(),
        //layout: SwiperLayout.CUSTOM,
      ),
    );
  }
}
