import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final _icons = <String, IconData>{
  'home': Icons.home,
  'location_on': Icons.location_on,
  'bookOpenPageVariant': MdiIcons.bookOpenPageVariant,
  'person': Icons.person,
  'descripcion': Icons.description,
  'duracion': Icons.timer,
  'costo': Icons.monetization_on
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.blue);
}
