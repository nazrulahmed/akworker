import 'package:flutter/material.dart';

class CustomShimmerRowItem {
  int _height;
  int _width;
  EdgeInsetsGeometry margin;


  CustomShimmerRowItem(this._height, this._width,
      {this.margin = const EdgeInsets.all(0)});

  get width => this._width;
  get height => this._height;
}

class CustomShimmerCol {
  int _height;
  int _width;

  CustomShimmerCol(this._height, this._width);
  get width => this._width;
  get height => this._height;
}
