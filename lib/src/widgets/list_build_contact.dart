import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/chat_model.dart';
import 'package:muro_dentcloud/src/models/list_message_model.dart';
import 'package:muro_dentcloud/src/pages/chat_pages.dart';

class ListWidgetChat extends StatelessWidget {
  final Size size1;
  final int id;
  final email;
  final List<UltimosMensaje> lista_chats;

  const ListWidgetChat({
    Key key, 
    @required this.size1,
    @required this.id, 
    @required this.lista_chats, this.email}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final listchat = new DataProvider();
   if(lista_chats[id].receptor==email)
    {
       return ListTile(
      leading: Container(
        width: size1.width * 0.125,
        //height: size1.height*0.08,
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: FadeInImage(
            height: size1.height * 0.05,
             //width: size1.width*0.05,
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(lista_chats[id].datosEmisor[0].fotoEmisor),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(lista_chats[id].datosEmisor[0].emisorAbreviado,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      subtitle: Text(
        lista_chats[id].contenidoMensaje,
        style: TextStyle(fontSize: 14),
        maxLines: 1,
      ),
      trailing: Text(lista_chats[id].timeHour, style: TextStyle(fontSize: 14)),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      nombre: lista_chats[id].datosEmisor[0].emisorAbreviado,
                     loguiado: email,
                       correotro:lista_chats[id].datosEmisor[0].correoEmisor,
                      sala: lista_chats[id].sala,
                      foto:lista_chats[id].datosEmisor[0].fotoEmisor,
                    )));
        // user_email_receptor
        // nombre_del usuario
        // url_photo
        //
        //Navigator.pushNamed(context, 'patients');
      },
    );
    }
    else
    {
     return ListTile(
      leading: Container(
        width: size1.width * 0.125,
        //height: size1.height*0.08,
        decoration: BoxDecoration(
            color: Colors.white60, borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: FadeInImage(
            height: size1.height * 0.07,
            // width: size1.width*0.05,
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(lista_chats[id].datosReceptor[0].fotoReceptor),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(lista_chats[id].datosReceptor[0].receptorAbreviado,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      subtitle: Text(
        lista_chats[id].contenidoMensaje,
        style: TextStyle(fontSize: 14),
        maxLines: 1,
      ),
      trailing: Text(lista_chats[id].timeHour, style: TextStyle(fontSize: 14)),
      onTap: () {
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      nombre: lista_chats[id].datosReceptor[0].receptorAbreviado,
                      loguiado: email,
                      correotro: lista_chats[id].datosReceptor[0].correoReceptor,
                      sala: lista_chats[id].sala,
                      foto: lista_chats[id].datosReceptor[0].fotoReceptor,
                    )));
        // user_email_receptor
        // nombre_del usuario
        // url_photo
        //
        //Navigator.pushNamed(context, 'patients');
      },
    );
    }
  }

}