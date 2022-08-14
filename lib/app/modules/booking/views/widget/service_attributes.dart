import 'dart:convert';

import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:flutter/material.dart';

class ServiceAttribute extends StatelessWidget {
  final attributes;
  ServiceAttribute(this.attributes);

  @override
  Widget build(BuildContext context) {
    List<Widget> attributeWidget = [];
    final data = jsonDecode(attributes);
    int i = 0;
    void addAttributeItem(k, v) {
      i++;
      attributeWidget.add(
        Row(children: [
          Text(
            '$k: ',
            style: MyTextStyle.textBlackMediumBold,
          ),
          Text(
            '$v',
            style: MyTextStyle.textBlackMedium,
          )
        ]),
      );
      if(i!=data.length) attributeWidget.add(Divider());
    }

    data.forEach((k, v) => addAttributeItem(k, v));

    return Container(
      child: Column(children: attributeWidget),
    );
  }
}
