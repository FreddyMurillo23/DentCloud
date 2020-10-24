import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/widgets/cards.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';
import 'package:muro_dentcloud/src/widgets/appbars/profile_appbar.dart';

class CurrentUserProfile extends StatefulWidget {
  final CurrentUsuario currentuser;
  const CurrentUserProfile({Key key, this.currentuser}) : super(key: key);

  @override
  _CurrentUserProfileState createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> {
  final prefs = new PreferenciasUsuario();
  final publicacionesProvider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    // print(userinfo.publicaciones);
    return Scaffold(
      body: FutureBuilder(
          future: publicacionesProvider
              .getPublicacionesByUser(userinfo.publicaciones),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return CustomScrollView(
              slivers: [
                ProfileAppBar(
                  userinfo: userinfo,
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                    child: Rooms(
                      userinfo: userinfo,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 10,
                  ),
                ),
                publicaciones(userinfo, _screenSize, snapshot),

                // SliverPublicaciones(),
              ],
            );
          }),
    );
  }

  Widget publicaciones(
      CurrentUsuario userinfo, Size _screenSize, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        // print(snapshot.data.length);
        return CardWidgetPublicaciones(publicaciones: snapshot.data, id: index);
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
