import 'package:flutter/material.dart';

Widget loadingIndicator({Color color}) {
  return Center(
      child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(color ?? Color(0xFFFFD800))));
}
