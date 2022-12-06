import 'dart:async';

import 'package:dognut_cli/app/common/const.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:developer';
import 'dart:convert';
import 'package:udp/udp.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  bool isConnected = false;
  StreamSubscription<Uint8List>? stream;
  Uint8List pixels = Uint8List(0);

  @override
  void onInit() {
    super.onInit();
    log('im in init');
  }

  Future<void> sendBoardcast() async {
    for (int i = 0; i < UPD_PORT_RANGE; i++) {
      var ret = await sendBoardcastOnce(UDP_PORT_BASE + i);
      if (ret) {
        break;
      }
    }
  }

  Future<bool> sendBoardcastOnce(port) async {
    var brd = Endpoint.broadcast(port: Port(port));
    var sender = await UDP.bind(Endpoint.any());
    bool ret = false;
    var stream = sender.asStream().listen((event) {
      if (event != null) {
        var str = String.fromCharCodes(event.data);
        var obj = json.decode(str);
        connectDataServer(event.address, obj["port"]);
        ret = true;
      }
    }, onError: (e) {
      log("send brd error $port");
    }, onDone: () {
      log("send brd done $port");
    });

    await sender.send('Foo'.codeUnits, brd);
    await 2.seconds.delay();
    stream.cancel();
    return ret;
  }

  void connectDataServer(address, port) {
    log("will connect $address $port");
    Socket.connect(address, port).then((clientSocket) async {
      stream = clientSocket.listen((event) {
        pixels = event;
        if (pixels.length == 307200) update();
      }, onError: (e) {
        log("on error: $e");
      }, onDone: () {
        log("im done");
        stream = null;
      });
    });
  }

  @override
  void onReady() {
    super.onReady();
    tick();
  }

  void tick() async {
    while (true) {
      if (stream == null) {
        await sendBoardcast();
      }
      await 10.seconds.delay();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
