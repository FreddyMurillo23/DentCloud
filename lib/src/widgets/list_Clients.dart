import 'package:flutter/material.dart';
import 'package:muro_dentcloud/src/models/userData_models.dart';

class ListaUsuarios extends StatelessWidget {
  final List<Usuario> usuariosData;

  const ListaUsuarios(this.usuariosData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.usuariosData.length,
      itemBuilder: (BuildContext context, int index) {
        return _ListaUsuarios(usuario: this.usuariosData[index], index: index);
      },
    );
  }
}

class _ListaUsuarios extends StatelessWidget {
  final Usuario usuario;
  final int index;

  const _ListaUsuarios({@required this.usuario, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_TarjetaTopBar(usuario, index)],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Usuario usuario;
  final int index;

  const _TarjetaTopBar(this.usuario, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: TextStyle(color: Colors.red),
          ),
          Text('${usuario.userNames}'),
        ],
      ),
    );
  }
}
