import 'package:control_bank_accounts/core/conts/app.dart';
import 'package:flutter/material.dart';

extension MyPadding on Widget {
  Widget customHorizontal() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: App.horizontal),
      child: this,
    );
  }
}
