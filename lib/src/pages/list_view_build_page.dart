import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/chat_model.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
import 'package:muro_dentcloud/src/resource/preferencias_usuario.dart';
import 'package:muro_dentcloud/src/search/search_delegate.dart';
import 'package:muro_dentcloud/src/widgets/circle_button.dart';
import 'package:muro_dentcloud/src/widgets/list_build_contact.dart';

class ListPage extends StatefulWidget {
  
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final listachatProvider = new DataProvider1();
  final prefs=new PreferenciasUsuario();
  
   Future<List<UltimosMensaje>> listaChat;
  Timer timer;
   _getlista(String email)
  {
    setState(() 
    {
      listaChat=listachatProvider.getListaChat(email);
    });
  }
  initState() {
     String correo= prefs.currentCorreo;
     super.initState();
    _getlista(correo);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getlista(correo));
    }
  
  @override
  Widget build(BuildContext context) {
    CurrentUsuario userinfo = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(size),
      body: Column(
        children: <Widget>[
          barraBusqueda(context, userinfo),
          Expanded(child: estado(size,userinfo)),
        ],
      ),
    );
  }

  
  Widget estado(Size size,CurrentUsuario userinfo) {
  return SafeArea(
    child: _list(size, userinfo),
  );
}

  Widget _list(Size size, CurrentUsuario userinfo) {
    
    return FutureBuilder(
      future: listaChat,
      builder: (BuildContext context,AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) 
        {
          return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index)
          {
            return ListWidgetChat(
              size1: size, id: index,lista_chats: snapshot.data,
              email: userinfo.correo,
            );

          },
          );

        }
        if(snapshot.hasError){
          print(snapshot.error);
        }

        return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
          );

      },
    );
  }

  Widget appMenu(Size _screenSize) {
  return AppBar(
    brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Image(
        image: AssetImage('assets/title.png'),
        height: _screenSize.height * 0.1,
        fit: BoxFit.fill,
      ),
      centerTitle: false,

    actions: <Widget>[
      CircleButton(
          icon: MdiIcons.forumOutline,
          iconsize: 30.0,
          onPressed: (){}, colorBorde: null, colorIcon: null,
          // onPressed: () => Navigator.pushNamed(context, 'messenger', arguments: userinfo),
        )
    ],
  );
 }
 

}

Widget barraBusqueda(BuildContext context, CurrentUsuario userinfo) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ClipRRect(
      //
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        decoration: InputDecoration(
            hintText: "  Buscar..",
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 19),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100))),
       onTap: (){
         showSearch(context: context, delegate: ChatSearch(userinfo.correo),);
         //showSearch(context: context, delegate: UserBusinessSearch());
       },
       readOnly: true,
      ),
    ),
  );
}