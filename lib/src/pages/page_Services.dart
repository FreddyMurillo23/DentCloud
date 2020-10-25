import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/widgets/business_ServicesWg.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';

class BusinessServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String ruc = ModalRoute.of(context).settings.arguments;
    final HttpService httpService = HttpService();
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
        actions: [
          CircleButton(
            icon: Icons.search,
            iconsize: 30.0,
            onPressed: () => print('Search'),
          ),
          CircleButton(
            icon: MdiIcons.facebookMessenger,
            iconsize: 30.0,
            onPressed: () => print('Messenger'),
          )
        ],
      ),
      body: Container(
        height: screenSize.height * 0.99,
        child: FutureBuilder(
          future: httpService.getBusinessServices(ruc),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return BusinessServicesWg(snapshot.data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
