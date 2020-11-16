import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/lista_chat_model.dart';
import 'package:muro_dentcloud/src/providers/chat_provider.dart';
import 'package:provider/provider.dart';

import 'burbuja_chat.dart';


class GetBodyChat1 extends StatefulWidget {
   final email;
  final sala;
  final verificacion;
  const GetBodyChat1({Key key, this.email, this.sala, this.verificacion}) : super(key: key);
  @override
  _GetBodyChat1State createState() => _GetBodyChat1State();
}

class _GetBodyChat1State extends State<GetBodyChat1> {
  ScrollController scrollController = new ScrollController();
   var verificar=0;
   Timer timer;
   var salaactualizada;
   ChatObtenidoProvider chat;
  @override
  Widget build(BuildContext context) {
    if(widget.sala==null)
    {
       return Scaffold(
         body: Container(),
       );
    }
    else
    {
       final screenSize = MediaQuery.of(context).size;
      salaactualizada=widget.sala;
     chat=Provider.of<ChatObtenidoProvider>(context);
    chat.chatActual(salaactualizada);
    return Scaffold(
     //appBar:AppBar() ,
      body: Selector<ChatObtenidoProvider,List<ChatSeleccionado>>(
        selector: (context,model ) => model.chatSelecionado,
        builder: (context, value, child) => 
        Column(
          children: [
             listaChat(screenSize,scrollController,value),
          ],
        ),
      ),
    );
    }
    
    if(verificar==0)
    {
      Timer(
    Duration(seconds: 1),
    () =>scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
    }
    
  }
   Widget listaChat(Size screenSize,ScrollController scrollController, List<ChatSeleccionado> mensajeslista) {
    
    if(mensajeslista.length!=0)
    {
     return Container(
        height: screenSize.height * 0.8,
       child: ListView.builder(
       controller:scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.all(15),
                itemCount: mensajeslista.length,
                itemBuilder: (BuildContext context, int index) {
                  verificar=1;
                  return BurbujaChat(
                    id: index,
                    mensajitos: mensajeslista,
                    correoLoggeado: widget.email,
                  );

                },
         
         ),
     );
    }
    return Container();
  }
}