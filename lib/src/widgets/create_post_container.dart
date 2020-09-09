import 'package:flutter/material.dart';

class CreatePostContainer extends StatelessWidget {
  final String currentUser;

  const CreatePostContainer({Key key, @required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.orange,
    );
  }
}
