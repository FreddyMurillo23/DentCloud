import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/search_contact_model.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
class ChatSearch extends SearchDelegate
{
  @override
  final useremail;
  ChatSearch(this.useremail);
  
  final chatProvider = new DataProvider();
   String seleccion=" ";
  @override
  List<Widget> buildActions(BuildContext context) {
      // Actiones que se van dar
      return [
        IconButton(icon: Icon(Icons.clear), 
        onPressed: (){
         query='';

        })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
     // inicio de regreso 
      
      return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
      ), 
      onPressed: (){
         close(context,null);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crear los resultado que vamos a mostrar
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
    //Sugerencia  que se va a dar para la busqueda
    if(query.isEmpty)
    {
      return Container();

    }

    return FutureBuilder(
      future: chatProvider.buscar_chat(useremail, query),
      builder: (BuildContext context, AsyncSnapshot<List<BusquedaNombre>> snapshot) {
        if(snapshot.hasData)
        {
          final contactos = snapshot.data;
          return ListView(
            children: contactos.map((chatcontactos) {
              return  ListTile(
                leading: FadeInImage(
                  image: NetworkImage(chatcontactos.foto),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(chatcontactos.receptor),
                onTap: (){
                  close(context, null);
                  // navegadoress
                  //Navigator.pushNamed(context, 'detalle',arguments: chatcontactos)
                },

              );

            }).toList(),
          );


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