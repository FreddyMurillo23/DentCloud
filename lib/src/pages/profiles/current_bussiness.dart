import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/business_Services_models.dart';
import 'package:muro_dentcloud/src/models/business_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/appbars/business_profile_appbar.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_viewBusiness.dart';
import 'package:muro_dentcloud/src/widgets/appbars/profile_appbar.dart';

class CurrentBusinessProfile extends StatefulWidget {
  final CurrentUsuario currentuser;
  final String currentBusiness;
  const CurrentBusinessProfile({Key key,  this.currentBusiness,
  this.currentuser})
      : super(key: key);

  @override
  _CurrentBusinessProfileState createState() => _CurrentBusinessProfileState();
}

class _CurrentBusinessProfileState extends State<CurrentBusinessProfile> {
  final prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final login = new DataProvider();
    return FutureBuilder(
        future: login.businessData(widget.currentBusiness),
        builder: (BuildContext context, AsyncSnapshot<List> businessinfo) {
          if (businessinfo.hasData) {
            return Scaffold(
              body: FutureBuilder(
                  future: publicacionesProvider.getPublicacionesByRuc(
                      businessinfo.data[0].openPublicacionesNegocio),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    return CustomScrollView(
                      slivers: [
                        BusinessAppBar(
                          userinfo: businessinfo.data[0],
                          usuario: widget.currentuser,
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
            return  Container(
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
        return CardWidgetPublicaciones(publicaciones: snapshot.data, id: index,space: true,);
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
