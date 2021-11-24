import 'dart:async';

import 'package:flutter/services.dart';

class WifiStatePlugin {
  static const MethodChannel _channel = const MethodChannel('wifi_state');

  static const EventChannel _channelEvent =
      EventChannel('wifi_state_plugin_eventChannel');

  WifiStatePlugin() {
    _channel.setMethodCallHandler(methodCallHandler);
  }

  late StreamController<bool> streamController;

  @override
  Future<dynamic> methodCallHandler(MethodCall call) {
    return Future<dynamic>(() {
      if (call.method == 'wifiResponse') {
        print('setMethodCallHandler ${call.arguments}');
        streamController.sink.add(call.arguments);
      }
    });
  }

  Future<bool?> get getWifiState async {
    final bool? value = await _channel.invokeMethod('getWifiState');
    return value;
  }

  Future<void> sendNotification(String title, String message) async {
    var args = {"title": title, "message": message};
    await _channel.invokeMethod('sendNotification', args);
  }

  Stream<bool> get startWifiStateListen {
    streamController = StreamController.broadcast();
    _channel.invokeMethod('startWifiStateListen');

    return streamController.stream;
  }

  Stream<bool>? get getWifiStateEvents =>
      _channelEvent.receiveBroadcastStream().map((event) => event);

  Future<bool?> get stopWifiStateListen async {
    await streamController.close();
    final bool? result = await _channel.invokeMethod('stopWifiStateListen');
    return result;
  }
}
