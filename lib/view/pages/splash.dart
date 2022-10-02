import 'package:control_bank_accounts/core/conts/colors.dart';
import 'package:control_bank_accounts/core/conts/fonts.dart';
import 'package:control_bank_accounts/core/conts/lotties.dart';
import 'package:control_bank_accounts/core/conts/routing/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/conts/icons.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );
    _controller.addStatusListener((status) {
      if(status.name == 'completed'){
        Get.offAllNamed(Pages.homePage);
      }
    });
  }
}

class Splash extends GetWidget<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, AppColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 0.8],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            AppLotties.splash,
            controller: controller._controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              controller._controller
                ..duration = composition.duration
                ..forward();
            },
          ),
          ),
        ),
    );
  }
}
