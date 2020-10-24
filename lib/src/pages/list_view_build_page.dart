import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/search/search_delegate.dart';
import 'package:muro_dentcloud/src/widgets/list_build_contact.dart';

class ListPage extends StatefulWidget {
  
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final listachatProvider = new DataProvider();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appMenu(),
      body: Column(
        children: <Widget>[
          barraBusqueda(context),
          Expanded(child: estado(size)),
        ],
      ),
    );
  }

  
  Widget estado(Size size) {
  return SafeArea(
    child: _list(size),
  );
}

  Widget _list(Size size) 
  {
    
    return FutureBuilder(
      future: listachatProvider.getListChat("fmurillo4888@utm.edu.ec"),
      builder: (BuildContext context,AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) 
        {
          return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
            return ListWidgetChat(
              size1: size, id: index,lista_chats: snapshot.data,
            );

          },
          );

        }
        if(snapshot.hasError){
          print(snapshot.error);
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

  Widget appMenu() {
  return AppBar(
    title: Text(
      "Inbox",
      style: TextStyle(fontSize: 25),
    ), //
    elevation: 5,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      tooltip: 'atras',
      onPressed: () {},
    ),
    actions: <Widget>[
      IconButton(
          icon: const Icon(Icons.add_to_home_screen),
          tooltip: 'mensaje',
          onPressed: () {}),
    ],
  );
 }
 

}

Widget barraBusqueda(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ClipRRect(
      //
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search..",
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 19),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100))),
       onTap: (){
         showSearch(context: context, delegate: ChatSearch("fmurillo4888@utm.edu.ec"),);
       },
       readOnly: true,
      ),
    ),
  );
}