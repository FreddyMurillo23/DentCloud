/*import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/models/follows_model.dart';

class FollowsSearch extends SearchDelegate
{
  final followProvider = new DataProvider();
    String seleccion=" ";
  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
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
     if(query.isEmpty)
    {
      return Container();

    }
    return FutureBuilder(
      future: followProvider.drougs(query),
      builder: (BuildContext context, AsyncSnapshot<List<Medicamento>> snapshot) {
        if(snapshot.hasData)
        {
          final follow = snapshot.data;
          return ListView(
            children: follow.map((medicamentobuscado) {
              return  Column(
                children: [
                  ListTile(
                    leading: Icon(MdiIcons.pill),
                    title: Text(medicamentobuscado.drugName),
                    subtitle: Text(medicamentobuscado.drugConcentration),
                    onTap: (){
                      close(context, null);
                      // navegadoress
                      //Navigator.pushNamed(context, 'detalle',arguments: chatcontactos)
                    },

                  ),
                  Divider(),
                ],
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

}*/