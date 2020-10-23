import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
class PostPublicaciones extends StatefulWidget {
  final CurrentUsuario currentuser;
  const PostPublicaciones({Key key, @required this.currentuser}) : super(key: key);

  @override
  _PostPublicacionesState createState() => _PostPublicacionesState();
}

class _PostPublicacionesState extends State<PostPublicaciones> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final publicacionesProvider = new DataProvider();
    return Scaffold(

      body: Container(),
    );
  }
}