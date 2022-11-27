import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:developer';

class HomeController extends GetxController {
  final count = 0.obs;
  bool isConnected = false;
  StreamSubscription<Uint8List>? stream;

  @override
  void onInit() {
    super.onInit();
    log('im in init');
  }

  @override
  void onReady() {
    super.onReady();
    log('will connect');
    Socket.connect("127.0.0.1", 9527).then((clientSocket) {
      stream = clientSocket.listen(
        (event) {
          log('event : $event');
        },
      );

      log('connect ok');
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}