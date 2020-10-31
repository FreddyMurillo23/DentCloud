import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/providers/data_provider.dart';
import 'package:muro_dentcloud/src/models/drougs_model.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_drougs.dart';
import 'package:muro_dentcloud/src/widgets/card_expansion_list.dart';

class DrogSearch extends SearchDelegate {
  final chatProvider = new DataProvider();
  String seleccion = " ";
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
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
    final _screenSize = MediaQuery.of(context).size;
    if (query.isEmpty) {
      return Image(
        height: _screenSize.height,
        width: _screenSize.width,
        image: AssetImage('assets/Medical.gif'),
        fit: BoxFit.cover,
      );
    }
    return FutureBuilder(
      future: chatProvider.drougs(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<Medicamento>> snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          final medicamentos = snapshot.data;
          return Stack(
            children: [
              Image(
                height: _screenSize.height,
                width: _screenSize.width,
                image: AssetImage('assets/Medical.gif'),
                fit: BoxFit.cover,
              ),
              ListView(
                children: medicamentos.map((medicamentobuscado) {
                  return Column(
                    children: [
                      CardExpansionPanelDrougs(
                        headerData: medicamentobuscado.drugName,
                        subtitle: medicamentobuscado.drugConcentration,
                        icon: MdiIcons.pill,
                        iconColor: Colors.grey.shade600,
                        lista: _data(medicamentobuscado),
                        // icon: ,
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              Image(
                height: _screenSize.height,
                width: _screenSize.width,
                image: AssetImage('assets/Medical.gif'),
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.white30,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(2.0, 10.0))
                      ]),
                  // color: Colors.white,
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _data(Medicamento medicamento) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Forma farmaceutica:'),
            subtitle: Text(medicamento.drugPharmaceuticalForm),
          ),
          ListTile(
            title: Text('Via de administracion:'),
            subtitle: Text(medicamento.drugAdministration),
          ),
          ListTile(
            title: Text('Concentracion:'),
            subtitle: Text(medicamento.drugConcentration),
          ),
          ListTile(
            title: Text('Tipo de producto:'),
            subtitle: Text(medicamento.drugKindOfProduct),
          ),
          ListTile(
            title: Text('Laboratorio:'),
            subtitle: Text(medicamento.drugManufacturingLaboratory),
          ),
          ListTile(
            title: Text('Indicaciones:'),
            subtitle: Text(medicamento.drugIndications),
          ),
          ListTile(
            title: Text('Contraindicaciones:'),
            subtitle: Text(medicamento.drugContraindications),
          ),
          ListTile(
            title: Text('Forma parte de el Cuadro Nacional de Medicamentos Basicos?'),
            subtitle: Text(medicamento.drugCnmb),
          ),
          // Divider(),
          ListTile(
            title: Text('Numero de registro sanitario 2020 :'),
            subtitle: Text(medicamento.drugHealthRegister),
          ),
          
          
        ],
      ),
    );
  }
}
