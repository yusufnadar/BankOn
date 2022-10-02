import 'package:flutter/material.dart';

import '../../core/const/app.dart';

extension MyPadding on Widget {
  Widget customHorizontal() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: App.horizontal),
      child: this,
    );
  }
}
