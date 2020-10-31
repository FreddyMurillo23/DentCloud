import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/current_user_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:muro_dentcloud/src/models/publications_model.dart';
import 'package:muro_dentcloud/src/pages/Inicio/post_publicaciones.dart';
import 'package:muro_dentcloud/src/search/search_follows_business.dart';

class CardExpansionPanel1 extends StatelessWidget {
  final String headerData;
  final email;
  final CurrentUsuario currentuser;
  const CardExpansionPanel1({
    Key key,
    @required this.headerData,
    @required  this.email, this.currentuser
  }) : super(key: key);
  @override
  
    Widget build(BuildContext context) {
       var actualizacion ;
      return Card(
        margin:
            new EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: ListTile(
          leading: Icon(MdiIcons.bookSearchOutline),
          title: Text(headerData),
          trailing: Icon(MdiIcons.play),
          onTap: () async {
            final negocio= await showSearch(context: context, delegate:  FollowsBusinessSearch(email,actualizacion));
            
             
                }
          
        ),
      );
    }
  }
  
  

