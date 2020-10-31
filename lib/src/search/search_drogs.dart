import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/models/drougs_model.dart';

class DrogSearch extends SearchDelegate
{
   final chatProvider = new DataProvider();
    String seleccion=" ";
  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      return [
        IconButton(icon: Icon(Icons.clear), 
        onPressed: (){
         query='';

        }),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){

          },
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: implement buildLeading
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
      future: chatProvider.drougs(query),
      builder: (BuildContext context, AsyncSnapshot<List<Medicamento>> snapshot) {
        if(snapshot.hasData)
        {
          final medicamentos = snapshot.data;
          return ListView(
            children: medicamentos.map((medicamentobuscado) {
              return  ListTile(
                leading: Icon(MdiIcons.pill),
                title: Text(medicamentobuscado.drugName),
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