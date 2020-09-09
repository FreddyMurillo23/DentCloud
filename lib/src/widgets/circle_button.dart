import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconsize;
  final Function onPressed;

  const CircleButton(
      {Key key,
      @required this.icon,
      @required this.iconsize,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
          icon: Icon(icon),
          iconSize: iconsize,
          color: Colors.black,
          onPressed: onPressed),
    );
  }
}
