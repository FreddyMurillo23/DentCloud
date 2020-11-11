import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconsize;
  final Function onPressed;
  final Color colorBorde;
  final Color colorIcon;

  const CircleButton(
      {Key key,
      @required this.icon,
      @required this.iconsize,
      @required this.onPressed,
      @required this.colorBorde,
      @required this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: colorBorde,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          icon: Icon(icon),
          iconSize: iconsize,
          color: colorIcon,
          onPressed: onPressed),
    );
  }
}
