import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomImage extends StatelessWidget {
  final String imgId;
  final String imageUrl;
  final int width;
  final int height;
  CustomImage(this.imgId, this.imageUrl, this.width, this.height);
   @override
  Widget build(BuildContext context) {
     // https://github.com/flutter/flutter/issues/41563
     // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        imgId,
        (int viewId) => ImageElement()
          ..src = imageUrl
          ..width = width
          ..height = height);
    return Container(
      height: height as double,
      width: width as double,
      child: HtmlElementView(
        viewType: imgId,
      ),
    );
  }
}
