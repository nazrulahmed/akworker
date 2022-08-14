/*
  @version: 1.0.0
  @author : Nazrul
  @required: https://pub.dev/packages/shimmer
  @class type: generic 

*/

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer {
  Container shimmerContainer(double height, double width) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [getShimmerFromColor(width: width, height: height)],
      ),
    );
  }

  multiShimmerContainer(items) {
    List<Widget> shimmerWidgets = [];
    for (int i = 0; i < items.length; i++) {
         shimmerWidgets.add(items[i]);
      
    }
    return Container(
      margin: EdgeInsets.only(left: 12,bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: shimmerWidgets,
          )
        ],
      ),
    );
  }

  Shimmer getShimmerFromColor({required double width, required double height,
      double radius = 0, margin = null}) {
    return Shimmer.fromColors(
        baseColor: Color(0xffe5e5e5),
        highlightColor: Color(0xffeeeeee),
        enabled: true,
        child: Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
