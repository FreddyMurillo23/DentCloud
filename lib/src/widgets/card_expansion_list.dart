import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';

class CardExpansionPanel extends StatelessWidget {
  final String headerData;
  final IconData icon;
  final Color iconColor;
  final Widget lista;


  const CardExpansionPanel({
    Key key,
    @required this.headerData,
    @required this.icon,
    @required this.iconColor,
    @required this.lista,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: ExpansionTile(

        initiallyExpanded: false,
        title: Text(
          headerData,
          style: TextStyle(
            // color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        tilePadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        leading: Icon(
          icon,
          color: iconColor,
        ),
        children: <Widget>[
          // Text(valueData),
          lista
        ],
      ),
    );
  }
}
