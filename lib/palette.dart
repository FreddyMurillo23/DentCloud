import 'package:flutter/material.dart';

const icon_search = 'assets/icons/030-search.svg';

// Colors that we use in our app
const kPrimaryColor = Color(0xFFB2EBF2);
const kTextColor = Color(0xFF0097A7);
const kBackgroundColor = Color(0xFFE0F7FA);

const double kDefaultPadding = 20.0;

class Palette {
  static const Color scaffold = Color(0xFFF0F2F5);
  static const Color textColor = Color(0xFF1777F2);
  static const LinearGradient createRoomGradient =
      LinearGradient(colors: [Color(0xFF496AE1), Color(0xFF4BCB1F)]);

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black26]);
}
