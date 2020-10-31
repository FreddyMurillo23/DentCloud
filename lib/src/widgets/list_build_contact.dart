import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/list_message_model.dart';

class ListWidgetChat extends StatelessWidget {
  final Size size1;
  final int id;
  final List<ListaChat> lista_chats;

  const ListWidgetChat({
    Key key, 
    @required this.size1,
    @required this.id, 
    @required this.lista_chats}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final listchat = new DataProvider();
    return ListTile(
              leading: Container(
                width: size1.width * 0.125,
                //height: size1.height*0.08,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                    height: size1.height * 0.07,
                   // width: size1.width*0.05,
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(lista_chats[id].foto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(lista_chats[id].receptor,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              subtitle: Text(
                lista_chats[id].contenido,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Text(lista_chats[id].timeHour,
                  style: TextStyle(fontSize: 14)),
              onTap: () {
                // user_email_receptor
                // nombre_del usuario
                // url_photo
                // 
                //Navigator.pushNamed(context, 'patients');
              },
            );
  }

}