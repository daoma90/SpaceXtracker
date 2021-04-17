import 'package:flutter/material.dart';

import '../constants.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: colorWhite,
      height: 1,
      width: 150,
    );
  }
}
