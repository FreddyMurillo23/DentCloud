import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage("assets/images/logoutm.png"),),
      height: 100,
      width: 100,
    );
  }
}