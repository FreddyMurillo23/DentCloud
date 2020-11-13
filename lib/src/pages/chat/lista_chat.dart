import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/lista_chat_model.dart';
import 'package:muro_dentcloud/src/pages/chat/burbuja_chat.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
class GetBodyChat extends StatefulWidget {
  final email;
  final sala;
  GetBodyChat({Key key, this.sala, this.email}) : super(key: key);

  @override
  _GetBodyChatState createState() => _GetBodyChatState();
}

class _GetBodyChatState extends State<GetBodyChat> {
  Future<List<ChatSeleccionado>> mensajeslista;
  Timer timer;
  final mensajesData = new DataProvider1();
 ScrollController scrollController = new ScrollController();
  _getlista()
  {
    setState(() 
    {
      mensajeslista=mensajesData.obtenerChat(widget.sala);
      
    });

  }
   initState() {
    super.initState();
    _getlista();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) =>_getlista());
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          listaChat(screenSize,scrollController),
        ],
      ),
      //child: child,
    );
  }
  Widget listaChat(Size screenSize,ScrollController scrollController) {
    return FutureBuilder(
      future:mensajeslista,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: screenSize.height * 0.8,
            child: ListView.builder(
              controller:scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.all(15),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                
                return BurbujaChat(
                  id: index,
                  mensajitos: snapshot.data,
                  correoLoggeado: widget.email,
                );
              },
            ),
          );
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
}