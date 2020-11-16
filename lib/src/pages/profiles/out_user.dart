import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/appbars/external/out_profile_appbar.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';
import 'package:muro_dentcloud/src/widgets/appbars/profile_appbar.dart';

class OutUserProfile extends StatefulWidget {
  final CurrentUsuario currentuser;
  const OutUserProfile({Key key, this.currentuser}) : super(key: key);

  @override
  _OutUserProfileState createState() => _OutUserProfileState();
}

class _OutUserProfileState extends State<OutUserProfile> {
  final prefs = new PreferenciasUsuario();
  final provider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    String correo = ModalRoute.of(context).settings.arguments;
    print(correo);
    return Scaffold(
      drawer: NavDrawer(),
      body: FutureBuilder(
          future: provider.userData(correo),
          builder: (context, AsyncSnapshot<List> user) {
            if (user.hasData) {
              print(user.data[0].publicaciones);
              return FutureBuilder(
                  future: provider
                      .getPublicacionesByUser(user.data[0].publicaciones),
                  builder:
                      (BuildContext context, AsyncSnapshot publicacionesId) {
                    if (publicacionesId.hasData) {
                      // print();
                      return CustomScrollView(
                        slivers: [
                          OutProfileAppBar(
                            userinfo: user.data[0],
                          ),
                          SliverPadding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                            sliver: SliverToBoxAdapter(
                              child: Rooms(
                                userinfo: user.data[0],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(
                              height: 10,
                            ),
                          ),
                          publicacionesId.data.length != 0
                              ? publicaciones(user.data[0], _screenSize,
                                  publicacionesId.data[0])
                              :SliverToBoxAdapter(child: Container(),),

                          // SliverPublicaciones(),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget publicaciones(
      CurrentUsuario userinfo, Size _screenSize, dynamic snapshot) {
    if (snapshot.hasData) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        // print(snapshot.data.length);
        return CardWidgetPublicaciones(
          publicaciones: snapshot.data,
          id: index,
          space: true,
        );
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
