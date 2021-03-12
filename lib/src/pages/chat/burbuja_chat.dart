import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/lista_chat_model.dart';
import 'package:muro_dentcloud/src/pages/colors/colors.dart';
class BurbujaChat extends StatelessWidget {
   final int id;
  final String correoLoggeado;
  final List<ChatSeleccionado> mensajitos;
  const BurbujaChat({Key key, this.id, this.correoLoggeado, this.mensajitos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (correoLoggeado != mensajitos[id].emisor) {
       return usuarionoLogeado(screenSize);
    }
    else
    {
        return usuarioLogeado(screenSize);
    }
  }

  Widget usuarionoLogeado(Size screenSize){

    if( mensajitos[id].messageMessageType=="M")
    {
      return Container( 
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(mensajitos[id].timeHour),
            SizedBox(height: 5.0,),
           Text(mensajitos[id].messageContent),
         ],
       ),
       padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
       margin: EdgeInsets.only(top: 8.0,bottom: 8.0,right: 80),
       decoration: BoxDecoration(
         color: grey,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(15),
           bottomRight: Radius.circular(15)
         ),
       ),
      );
    }
    else if(mensajitos[id].messageMessageType=="I")
    {
      return Container( 
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(mensajitos[id].timeHour),
            SizedBox(height: 5.0,),

            FadeInImage(placeholder: AssetImage('assets/loading.gif'), image:NetworkImage(mensajitos[id].messageUrlContent),height: 150),
         ],
       ),
       padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
       margin: EdgeInsets.only(top: 8.0,bottom: 8.0,right: 80),
       decoration: BoxDecoration(
         color: grey,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(15),
           bottomRight: Radius.circular(15)
         ),
       ),
      );

    }
    
  }
  
  Widget usuarioLogeado(Size screenSize)
  {

    if(mensajitos[id].messageMessageType=="M")
    {
      return Container( 
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(mensajitos[id].timeHour),
           SizedBox(height: 5.0,),
           Text(mensajitos[id].messageContent),
         ],
       ),
       padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
       margin: EdgeInsets.only(top: 8.0,bottom: 8.0,left: 80),
       decoration: BoxDecoration(
         color: Colors.blue[100],
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(15),
           bottomRight: Radius.circular(15)
         ),

       ),
      );
    }
    else if(mensajitos[id].messageMessageType=="I")
    {
      return Container( 
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(mensajitos[id].timeHour),
            SizedBox(height: 5.0,),

            FadeInImage(placeholder: AssetImage('assets/loading.gif'), 
            image:NetworkImage(mensajitos[id].messageUrlContent),height: 150,),
         ],
       ),
       padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
       margin: EdgeInsets.only(top: 8.0,bottom: 8.0,left:  80),
       decoration: BoxDecoration(
         color: Colors.blue[100],
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(15),
           bottomRight: Radius.circular(15)
         ),
       ),
      );

    }
    
  
  }
  
  
  
  getBorderMessageType(String tipo) {
    if (correoLoggeado != mensajitos[id].emisor) {
      if (tipo == "M") {
        return BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20));
      } else if (tipo == "A") {
        return BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20));
      } else if (tipo == "I") {
        return BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20));
      }
      return BorderRadius.all(Radius.circular(20));
    } else {
      if (tipo == "M") {
        return BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(5));
      } else if (tipo == "A") {
        return BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5));
      } else if (tipo == "I") {
        return BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(20));
      }
      return BorderRadius.all(Radius.circular(20));
    }
  }
}