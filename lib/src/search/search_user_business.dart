import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/search_model/business_data_search.dart';
import 'package:muro_dentcloud/src/models/search_model/user_data_search.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';

class UserBusinessSearch extends SearchDelegate {
  final businessProvider = new DataProvider();
  String seleccion = " ";
  bool activar = true;
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
        future: businessProvider.buscarUsuario(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
          final userData = snapshot.data;
          if (snapshot.hasData) {
            return Stack(
              children: [
               Positioned(
                 top: 5,
                 left: 15,
                 child: ButtonTheme(
                   minWidth: sizescreen.width * 0.4,
                  child: RaisedButton(
                   child: Text('Usuario'),
                   onPressed: (){},
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))
                 ),
               )),
               Positioned(
                 top: 5,
                 right: 15,
                 child: ButtonTheme(
                   minWidth: sizescreen.width * 0.4,
                  child: RaisedButton(
                   child: Text('Negocio'),
                   onPressed: (){
                     activar=false;
                   },
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))
                 ),
               )),
               Positioned(
                 top: 70,
                 left: 70,
                 child: Container(
                   decoration: BoxDecoration(
                   ),
                   width: sizescreen.width*0.72,
                   height: sizescreen.height*0.75,
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
                          ),
                          Divider(),
                        ],
                        );
                     }),
                   //color: Colors.green,
                   )),

              ],
            );
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
      /* return FutureBuilder(
       builder: null
       );*/
    } else {
      return FutureBuilder(
        future: businessProvider.businesSearch(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Negocio>> snapshot) {
          final businesData = snapshot.data;
          if (snapshot.hasData) {
            return Stack(
              children: [
               Positioned(
                 top: 5,
                 left: 15,
                 child: ButtonTheme(
                   minWidth: sizescreen.width * 0.4,
                  child: RaisedButton(
                   child: Text('Usuario'),
                   onPressed: (){
                     activar=true;
                   },
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))
                 ),
               )),
               Positioned(
                 top: 5,
                 right: 15,
                 child: ButtonTheme(
                   minWidth: sizescreen.width * 0.4,
                  child: RaisedButton(
                   child: Text('Negocio'),
                   onPressed: (){
                  
                     activar=false;
                   },
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))
                 ),
               )),
               Positioned(
                 top: 70,
                 left: 70,
                 child: Container(
                   decoration: BoxDecoration(
                   ),
                   width: sizescreen.width*0.72,
                   height: sizescreen.height*0.75,
                   child: ListView.builder(
                     itemCount: businesData.length,
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
                                image:  NetworkImage(businesData[index].fotoNegocio),
                                fit: BoxFit.cover,
                                width: 50,
                              ),
                            ),
                            title: Text(businesData[index].nombreNegocio),
                          ),
                          Divider(),
                        ],
                        );
                     }),
                   //color: Colors.green,
                   )),

              ],
            );
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

  Widget negocio(Size sizescreen) {
    return Container(
      width: sizescreen.width * 0.48,
      child: Column(
        children: [
          Container(
            width: sizescreen.width * 0.3,
            child: ButtonTheme(
              minWidth: sizescreen.width * 0.35,
              child: Center(
                child: RaisedButton(
                  child: Text('Negocio'),
                  onPressed: () {},
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
