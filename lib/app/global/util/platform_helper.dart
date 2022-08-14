import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

const desktopWindowIdealSize = 768;
bool isDesktopView(BuildContext context) {
  return kIsWeb && MediaQuery.of(context).size.width >= desktopWindowIdealSize;
}
