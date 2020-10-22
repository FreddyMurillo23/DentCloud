import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/services/bServices_service.dart';
import 'package:muro_dentcloud/src/widgets/business_ServicesWg.dart';

class BusinessServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: FutureBuilder(
                future: httpService.getBusinessServices('1317054888001'),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return BusinessServicesWg(snapshot.data);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
