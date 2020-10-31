import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/utils/icono_string_util.dart';

class CardExpansionPanelDrougs extends StatelessWidget {
  final String headerData;
  final IconData icon;
  final Color iconColor;
  final Widget lista;
  final String subtitle;

  const CardExpansionPanelDrougs({
    Key key,
    @required this.headerData,
    @required this.icon,
    @required this.iconColor,
    @required this.lista,
    @required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 20 ,
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(
          headerData,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle,),
        tilePadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        leading: Icon(
          icon,
          color: iconColor,
        ),
        trailing: Icon(MdiIcons.arrowDownThinCircleOutline),
        children: <Widget>[
          // Text(valueData),
          lista
        ],
      ),
    );
  }
}
