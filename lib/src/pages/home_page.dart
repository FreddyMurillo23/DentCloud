import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/create_post_container.dart';
import 'package:muro_dentcloud/src/providers/menu_providers.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // leading: IconButton(
            //     icon: Icon(Icons.ac_unit,
            //     color: Colors.black
            //     ),
            //     onPressed: () {
            //       NavDrawer();
            //     }),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              'DentCloud',
              style: const TextStyle(
                color: Palette.textColor,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
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
          SliverToBoxAdapter(
            child: CreatePostContainer(currentUser: "Freddy"),
          )
        ],
      ),
    );
  }
}
