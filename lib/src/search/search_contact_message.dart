import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/search_model/contact_message.dart';
import 'package:muro_dentcloud/src/pages/chat_pages.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';

class ListaContactSeguidos extends SearchDelegate
{
 final useremail;
 ListaContactSeguidos(this.useremail);
 final chatProvider = new DataProvider1();
   String seleccion=" ";
  @override  
  List<Widget> buildActions(BuildContext context) {
     return [
        IconButton(icon: Icon(Icons.clear), 
        onPressed: (){
         query='';

        })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
   return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
      ), 
      onPressed: (){
         close(context,null);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
         return Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.blueAccent,
          child: Text(seleccion),

        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
   
     return FutureBuilder(
      future: chatProvider.listaContactoSeguido(useremail,query),
      builder: (BuildContext context, AsyncSnapshot<List<ContactoElement>> snapshot) {
        if(snapshot.hasData)
        {
          if(snapshot.data.length!=0)
        {
           return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index)
          {
            if(index==null)
            { 
              return Container();
            }else
            {
               return  Column(
                children: [
                  ListTile(
                    leading:FadeInImage(
                  image: NetworkImage(snapshot.data[index].fotoPerfilContacto),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  width: 50,
                  fit: BoxFit.contain,
                ), 
                    title: Text(snapshot.data[index].nombreContacto),
                    onTap: (){
                        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      nombre: snapshot.data[index].nombreContacto,
                     loguiado:useremail,
                       correotro:snapshot.data[index].emailContacto,
                      sala: 0,
                      foto:snapshot.data[index].fotoPerfilContacto,
                    )));
                    },

                  ),
                  Divider(),
                ],
              );
            }  
          },
          );
        }
        else
        {
          return Container();
        }

        }
        else
        {
          return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
          );
        }
              },
    );
  }

}