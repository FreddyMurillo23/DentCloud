import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/search_model/business_data_search.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_search.dart';
import 'package:muro_dentcloud/src/providers/data_provide1.dart';
//import 'package:muro_dentcloud/src/providers/data_provider.dart';

class UserBusinessSearch extends SearchDelegate {
  final businessProvider = new DataProvider1();
  String seleccion = " ";
  bool activar = true;
  var activado=Colors.blue[200];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
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
    final sizescreen = MediaQuery.of(context).size;
    if (activar == true) {
      return FutureBuilder(
        future: businessProvider.userSearch(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
          final userData = snapshot.data;
          if (snapshot.hasData) {
            return Container(
                 height: sizescreen.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: sizescreen.width*1,
                        height: sizescreen.height*0.08,
                        child: Row(
            children: [
            SizedBox(width: 5,),
                   ButtonTheme(
                       minWidth: sizescreen.width * 0.48,
                      child: Opacity(
                        opacity: 0.8,
                        child: RaisedButton(
                       color: activado,
                         child: Text('Usuario'),
                         onPressed: (){
                           activar=true;
                         },
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))
                     ),
                      ),
                     ),
                     SizedBox(width: 8,),
                     Container(
                       child: Opacity(
                         opacity: 0.8,
             child: ButtonTheme(
             minWidth: sizescreen.width * 0.47,
             child: RaisedButton(
                color: Colors.transparent,
             child: Text('Negocio'),
             onPressed: (){
               activar=false;
             },
             shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
                         ),
                       ),
                       ),
                     ),
            ],
                        ),
                      ),
                    
                    Card(
                      elevation: 10,
                                          child: Container(
                           decoration: BoxDecoration(
                           ),
                           width: sizescreen.width*0.9,
                           height: sizescreen.height*0.76,
                           child: ListView.builder(
             itemCount: userData.length,
             itemBuilder: (BuildContext context, int index){
               if(index==null)
               {
                 return Container();

               }
                return Column(
                children: [
                  ListTile(
                      leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif') ,
                      image:  NetworkImage(userData[index].fotoPerfilUsuario),
                      fit: BoxFit.cover,
                      width: 50,
                        ),
                      ),
                      title: Text(userData[index].nombreUsuario),
                      onTap: (){},
                  ),
                  Divider(),
                ],
                );
             }),
                           //color: Colors.green,
                           ),
                    ),

                    ],
                  ),
                ),
              );
          }
          else
          {
             return Container(
                 height: sizescreen.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: sizescreen.width*1,
                        height: sizescreen.height*0.08,
                        child: Row(
            children: [
            SizedBox(width: 5,),
                   ButtonTheme(
                       minWidth: sizescreen.width * 0.48,
                      child: Opacity(
                        opacity: 0.8,
                        child: RaisedButton(
            color: activado,
                         child: Text('Usuario'),
                         onPressed: (){
                           activar=true;
                         },
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))
                     ),
                      ),
                     ),
                     SizedBox(width: 8,),
                     Container(
                       child: Opacity(
                         opacity: 0.8,
             child: ButtonTheme(
             minWidth: sizescreen.width * 0.47,
             child: RaisedButton(
                color: Colors.transparent,
             child: Text('Negocio'),
             onPressed: (){
               activar=false;
             },
             shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
                         ),
                       ),
                       ),
                     ),
            ],
                        ),
                      ),
                    
                    Card(
                      elevation: 10,
                      child: Container(
                         width: sizescreen.width*0.9,
                          height: sizescreen.height*0.76,
                         child:Center(
                     child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                     ),
                   )
                           
                           //color: Colors.green,
                      ),
                    ),

                    ],
                  ),
                ),
              );
          }
        },
      );
    } else 
    {
      return FutureBuilder(
        future: businessProvider.businesSearch(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Negocio>> snapshot) {
          final userData = snapshot.data;
          if (snapshot.hasData) {
            return Container(
                 height: sizescreen.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: sizescreen.width*1,
                        height: sizescreen.height*0.08,
                        child: Row(
            children: [
            SizedBox(width: 5,),
                   ButtonTheme(
                       minWidth: sizescreen.width * 0.48,
                      child: Opacity(
                        opacity: 0.8,
                        child: RaisedButton(
            color: Colors.transparent,
                         child: Text('Usuario'),
                         onPressed: (){
                           activar=true;
                         },
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))
                     ),
                      ),
                     ),
                     SizedBox(width: 8,),
                     Container(
                       child: Opacity(
                         opacity: 0.8,
             child: ButtonTheme(
             minWidth: sizescreen.width * 0.47,
             child: RaisedButton(
                color: activado,
             child: Text('Negocio'),
             onPressed: (){
               activar=false;
             },
             shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
                         ),
                       ),
                       ),
                     ),
            ],
                        ),
                      ),
                    
                    Card(
                      elevation: 10,
                                          child: Container(
                           decoration: BoxDecoration(
                           ),
                           width: sizescreen.width*0.9,
                           height: sizescreen.height*0.76,
                           child: ListView.builder(
             itemCount: userData.length,
             itemBuilder: (BuildContext context, int index){
               if(index==null)
               {
                 return Container();

               }
                return Column(
                children: [
                  ListTile(
                      leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif') ,
                      image:  NetworkImage(userData[index].fotoNegocio),
                      fit: BoxFit.cover,
                      width: 50,
                        ),
                      ),
                      title: Text(userData[index].nombreNegocio),
                      onTap: (){},
                  ),
                  Divider(),
                ],
                );
             }),
                           //color: Colors.green,
                           ),
                    ),

                    ],
                  ),
                ),
              );
          }
          else
          {
             return Container(
                 height: sizescreen.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: sizescreen.width*1,
                        height: sizescreen.height*0.08,
                        child: Row(
            children: [
            SizedBox(width: 5,),
                   ButtonTheme(
                       minWidth: sizescreen.width * 0.48,
                      child: Opacity(
                        opacity: 0.8,
                        child: RaisedButton(
            color: Colors.transparent,
                         child: Text('Usuario'),
                         onPressed: (){
                           activar=true;
                         },
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))
                     ),
                      ),
                     ),
                     SizedBox(width: 8,),
                     Container(
                       child: Opacity(
                         opacity: 0.8,
             child: ButtonTheme(
             minWidth: sizescreen.width * 0.47,
             child: RaisedButton(
                color: activado,
             child: Text('Negocio'),
             onPressed: (){
               activar=false;
             },
             shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))
                         ),
                       ),
                       ),
                     ),
            ],
                        ),
                      ),
                    
                    Card(
                      elevation: 10,
                      child: Container(
                         width: sizescreen.width*0.9,
                          height: sizescreen.height*0.76,
                         child:Center(
                     child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                     ),
                   )
                           
                           //color: Colors.green,
                      ),
                    ),

                    ],
                  ),
                ),
              );
          }
        },
      );
      
    }
  }
}
