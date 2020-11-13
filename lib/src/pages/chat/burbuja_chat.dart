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
    if( mensajitos[id].messageContent!=null)
    {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: <Widget>[
            Container(
              child: Text(mensajitos[id].timeHour),
            ),
            SizedBox(
              width: screenSize.width * 0.025,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.0035),
              //width: screenSize.width*0.45,
              child: Expanded(
                            child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          getBorderMessageType(mensajitos[id].messageMessageType),
                      color: grey),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      mensajitos[id].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    else
    {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: <Widget>[
            Container(
              child: Text(mensajitos[id].timeHour),
            ),
            SizedBox(
              width: screenSize.width * 0.025,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.0035),
              width: screenSize.width*0.45,
              child: Expanded(
                            child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          getBorderMessageType(mensajitos[id].messageMessageType),
                      color: grey),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FadeInImage(
                          image: NetworkImage(mensajitos[id].messageUrlContent),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          fit: BoxFit.cover,
                     ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

    }
    
  }
  
  Widget usuarioLogeado(Size screenSize)
  {
    if(mensajitos[id].messageContent!=null)
    {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.0035),
              width: screenSize.width*0.45,
              child: Expanded(
                        child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          getBorderMessageType(mensajitos[id].messageMessageType),
                      color: primary),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      mensajitos[id].messageContent,
                      style: TextStyle(fontSize: 15, color: white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.025,
            ),
            Container(
              child: Text(mensajitos[id].timeHour),
            ),
          ],
        ),
      );
    }
    else
    {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.0035),
              width: screenSize.width*0.45,
              child: Expanded(
                        child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          getBorderMessageType(mensajitos[id].messageMessageType),
                      color: primary),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:FadeInImage(
                          image: NetworkImage(mensajitos[id].messageUrlContent),
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          fit: BoxFit.cover,
                     ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: screenSize.width * 0.025,
            ),
            Container(
              child: Text(mensajitos[id].timeHour),
            ),
          ],
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