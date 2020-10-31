import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/models/follows_model.dart';

class FollowsSearch extends SearchDelegate
{
   @override
  final useremail;
  FollowsSearch(this.useremail);
  final followProvider = new DataProvider();
    String seleccion=" ";
  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(icon: Icon(Icons.clear), 
        onPressed: (){
         query='';

        }),
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
      future: followProvider.follow_search(useremail, query),
      builder: (BuildContext context, AsyncSnapshot<List<Siguiendo>> snapshot) {
        if(snapshot.hasData)
        {
          if(snapshot.data.length!=0)
        {
          
           return ListView.builder(
          itemCount: snapshot.data[0].usuariosSeguidos.length,
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
                  image: NetworkImage(snapshot.data[0].usuariosSeguidos[index].fotoPerfil),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  width: 50,
                  fit: BoxFit.contain,
                ), 
                    title: Text(snapshot.data[0].usuariosSeguidos[index].nombreUsuario),
                    onTap: (){
                      close(context, null);
                      // navegadoress
                      //Navigator.pushNamed(context, 'detalle',arguments: chatcontactos)
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