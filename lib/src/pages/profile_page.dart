import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/controllers/users_ctrl.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';
import 'package:muro_dentcloud/src/widgets/profile_appbar.dart';

class ProfilePage extends StatefulWidget {
  final CurrentUsuario currentuser;
  const ProfilePage({Key key, this.currentuser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final _screenSize = MediaQuery.of(context).size;
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    // print(userinfo.publicaciones);
    return Scaffold(
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: [
          ProfileAppBar(
            userinfo: userinfo,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(),
            ),
          ),
          // SliverPublicaciones(),
        ],
      ),
    );
  }
}
