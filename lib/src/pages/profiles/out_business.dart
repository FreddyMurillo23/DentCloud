import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/appbars/business_profile_appbar.dart';
import 'package:muro_dentcloud/src/widgets/appbars/external/out_business_profile_appbar.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_viewbusiness.dart';
import 'package:muro_dentcloud/src/widgets/appbars/profile_appbar.dart';

class OutBusinessProfile extends StatefulWidget {

  const OutBusinessProfile({Key key,}) : super(key: key);

  @override
  _OutBusinessProfileState createState() => _OutBusinessProfileState();
}

class _OutBusinessProfileState extends State<OutBusinessProfile> {
  final prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    String currentBusiness = ModalRoute.of(context).settings.arguments;
    final login = new DataProvider();
    print(currentBusiness);
    return FutureBuilder(
        future: login.businessData(currentBusiness),
        builder: (BuildContext context, AsyncSnapshot<List> businessinfo) {
          if (businessinfo.hasData) {
            return Scaffold(
              // drawer: NavDrawer(currentuser: widget.currentuser),
              body: FutureBuilder(
                  future: publicacionesProvider.getPublicacionesByRuc(
                      businessinfo.data[0].openPublicacionesNegocio),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    return CustomScrollView(
                      slivers: [
                        OutBusinessAppBar(
                          userinfo: businessinfo.data[0],
                        ),
                        SliverPadding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                          sliver: SliverToBoxAdapter(
                            child: BusinessRooms(
                              businessinfo: businessinfo.data[0],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Divider(
                            height: 10,
                          ),
                        ),
                        publicaciones(_screenSize, snapshot),

                        // SliverPublicaciones(),
                      ],
                    );
                  }),
            );
          } else {
            return Container(
              height: _screenSize.height * 0.4,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget publicaciones(Size _screenSize, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        // print(snapshot.data.length);
        return CardWidgetPublicaciones(publicaciones: snapshot.data, id: index, space: true,);
      }, childCount: snapshot.data.length));
    } else {
      return SliverToBoxAdapter(
        child: Container(
          height: _screenSize.height * 4,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
