import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:muro_dentcloud/src/widgets/horizontal_scroll_view.dart';
import 'package:muro_dentcloud/src/widgets/profile_appbar.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _screenSize = MediaQuery.of(context).size;
    final datauser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: [
          ProfileAppBar(),
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
