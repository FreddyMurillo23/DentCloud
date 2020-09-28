import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/services/userData_service.dart';
import 'package:muro_dentcloud/src/widgets/list_Clients.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsUser = Provider.of<UserData>(context);

    return Container(
      child: ListaUsuarios(newsUser.usuario),
    );
  }
}
