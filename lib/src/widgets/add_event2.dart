import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/doctors_model.dart';
import 'package:muro_dentcloud/src/providers/doctores_provider.dart';
import 'package:muro_dentcloud/src/widgets/drawer_appbar.dart';
import 'package:provider/provider.dart';

class SeachAddEvent extends StatefulWidget {
  @override
  _SeachAddEventState createState() => _SeachAddEventState();
}

String a;
DoctoresProvider doctoresProvider;

class _SeachAddEventState extends State<SeachAddEvent> {
  
  @override
  Widget build(BuildContext context) {
    doctoresProvider = Provider.of<DoctoresProvider>(context);


    List<TableRow> getDoctores(List<Doctores> ingredientes){ 
    List<TableRow> tableRows = List<TableRow>();
    ingredientes.forEach((e) { 
      print(e.cedula);
      tableRows.add(
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
            ),
          ),
          children: [
            Text(e.cedula),
            IconButton(
              icon: Icon(Icons.edit,color: Colors.orange[400]),
              onPressed: () { }
            ),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.red[400]),
              onPressed: () { }
            )
        ]),
      );
    });

    return tableRows;
  }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("SearchExample"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    
                      Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Selector<DoctoresProvider,List<Doctores>>(
                      selector: (context, model) => model.doctores,
                      builder: (context, cats, widget) => Column(
                        children: <Widget>[
                          if (cats.length > 0) ...[
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: {                  
                                0: FlexColumnWidth(1),
                                1: FixedColumnWidth(40),
                                2: FixedColumnWidth(40),
                              },
                              children: 
                                getDoctores(cats)
                            )
                          ] else ...[
                            Center(
                               child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                            )
                          ]
                        ]
                      ),
                    ), 
                  ]
                ) 
              )
                    
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class DataSearch extends SearchDelegate<String>{

  final cities = [
    "Portoviejo",
    "Manta",
    "Chone",
    "San Pablo",
    "Crucita"
  ];

  final recenCities = [
    "San Pablo",
    "Crucita" 
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){query = "";},)
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return 
      IconButton(
        icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
        ), 
        onPressed: (){close(context, null);});
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Column(
        children: [
          Text(query)
        ],
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recenCities
    : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context,index) => ListTile(
      leading: Icon(Icons.location_city),
      title: Text(suggestionList[index]),
      onTap: () {
        query = suggestionList[index];
      },
    ),
    itemCount: suggestionList.length,
    );
  }
}