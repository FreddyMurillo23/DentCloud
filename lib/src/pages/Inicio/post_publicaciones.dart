// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';

// import 'package:muro_dentcloud/src/widgets/circle_button.dart';
// import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
class PostPublicaciones extends StatefulWidget {
  final CurrentUsuario currentuser;
  const PostPublicaciones({Key key, @required this.currentuser})
      : super(key: key);

  @override
  _PostPublicacionesState createState() => _PostPublicacionesState();
}

class _PostPublicacionesState extends State<PostPublicaciones> {
  TextEditingController controladorCorreoUser = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final publicacionesProvider = new DataProvider();
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          child: Column(
            children: <Widget>[
              _crearPost(),
              _etiquetas(),
              _bottonEnviarForm(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _crearPost() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Publicacion'),
    );
  }

  Widget _etiquetas() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Publicacion'),
    );
  }

  Widget _bottonEnviarForm() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.lightBlue,
      textColor: Colors.white,
      label: Text('Publicar'),
      icon: Icon(Icons.publish),
      onPressed: () {
        Navigator.pushNamed(context, 'prueba');
      },
    );
  }
}
// Column(
//         children: [
//           Card(
//             margin: new EdgeInsets.symmetric(
//                 horizontal: _screenSize.width * 0.035,
//                 vertical: _screenSize.height * 0.02),
//             child: Container(
//               // color: Colors.blue,
//               height: _screenSize.height * 0.35,
//             ),
//             elevation: 5,
//           ),
//           SizedBox(
//             height: _screenSize.height * 0.01,
//           ),
//           Container(
//             child: TextField(
//               controller: controladorCorreoUser,
//               decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.blueGrey[600],
//                   labelText: "Correo Electrónico",
//                   labelStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   enabled: false,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   )),
//             ),
//             color: Colors.blue,
//             height: _screenSize.height * 0.08,
//           ),
//           Divider(),
//           Container(
//             color: Colors.blue,
//             height: _screenSize.height * 0.08,
//           ),
//           Divider(),
//           Container(
//             color: Colors.blue,
//             height: _screenSize.height * 0.08,
//           ),
//         ],
//       ),
