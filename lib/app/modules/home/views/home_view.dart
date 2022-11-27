import 'package:dognut_cli/app/componet_views/debug_painter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dognut_cli/app/componet_views/debug_painter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return GestureDetector(
              onScaleStart: (d) {},
              onScaleUpdate: (ScaleUpdateDetails details) {},
              child: CustomPaint(
                painter: DebugPainter(),
              ),
            );
          },
        ),
      ),
    );
  }
}
