import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/palette.dart';
import 'package:muro_dentcloud/src/pages/card_page.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/create_post_container.dart';
import 'package:muro_dentcloud/src/providers/menu_providers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _lista(),
      // CustomScrollView(
      //     slivers: [
      //       SliverAppBar(
      //         brightness: Brightness.light,
      //         backgroundColor: Colors.white,
      //         title: Text(
      //           'DentCloud',
      //           style: const TextStyle(
      //             color: Palette.textColor,
      //             fontSize: 28.0,
      //             fontWeight: FontWeight.bold,
      //             letterSpacing: -1.2,
      //           ),
      //         ),
      //         centerTitle: false,
      //         floating: true,
      //         actions: [
      //           CircleButton(
      //             icon: Icons.search,
      //             iconsize: 30.0,
      //             onPressed: () => print('Search'),
      //           ),
      //           CircleButton(
      //             icon: MdiIcons.facebookMessenger,
      //             iconsize: 30.0,
      //             onPressed: () => print('Messenger'),
      //           )
      //         ],
      //       ),
      //       SliverToBoxAdapter(
      //         child: CreatePostContainer(currentUser: "Freddy"),
      //       )
      //     ],
      //   ),
    );
  }
}

Widget _lista() {
  return FutureBuilder(
    future: menuProvider.cargarData(),
    initialData: [],
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      print('builder');
      print(snapshot.data);

      return ListView(
        children: _listaItems(snapshot.data, context),
      );
    },
  );

  // // print(menuProvider.opciones);
  // menuProvider.cargarData().then((opciones) {
  //   print('_lista');
  //   print(opciones);
  // });
}

List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];

  data.forEach((opt) {
    final widgetTemp = ListTile(
      title: Text(opt['texto']),
      leading: getIcon(opt['icon']),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.blue,
      ),
      onTap: () {
        Navigator.pushNamed(context, opt['ruta']);

        // final route = MaterialPageRoute(builder: (context) {
        //   return CardPage();
        // });
        // Navigator.push(context, route);
      },
    );
    opciones..add(widgetTemp)..add(Divider());
  });
  return opciones;
}
