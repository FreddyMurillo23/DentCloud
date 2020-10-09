import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: Image(
          image: AssetImage("assets/logo.png"),
        ),
        
      ),
      height: 100,
        width: 100,
    );
  }
}
