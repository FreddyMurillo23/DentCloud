import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/services/business_Services_service.dart';
import 'package:muro_dentcloud/src/widgets/business_ServicesWg.dart';
import 'package:provider/provider.dart';

class BusinessServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final businessSer = Provider.of<BusinessServices>(context);
    final businessSer = BusinessServices();

    return Scaffold(
      body: FutureBuilder(
        future: businessSer.getBusinessServices('1304924424001'),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           print(snapshot);
          if (snapshot.hasData) {
            return BusinessServicesWg(snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
         
        },
      ),
    );
  }
}
