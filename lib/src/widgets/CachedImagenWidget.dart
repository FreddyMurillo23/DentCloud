import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageWidget extends StatelessWidget {

  String image;
  double width;
  double height;
  Icon icon;

  CachedImageWidget({@required this.image, this.height, this.width, @required this.icon});
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl: image,           
        width: width == null ? MediaQuery.of(context).size.width : width,
        height: height == null ? MediaQuery.of(context).size.height : height,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: icon),
        fadeInCurve: Curves.easeIn,
        fadeInDuration: Duration(milliseconds: 2000),
        fit: BoxFit.fill,
      ),
    );
  }
}