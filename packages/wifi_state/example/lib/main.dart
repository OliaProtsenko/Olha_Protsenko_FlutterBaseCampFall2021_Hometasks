import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wifi_state/wifi_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _wifiState = 'Unknown';
  late WifiStatePlugin wifiStatePlugin;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  String convertWifiState(bool? wifiState) {
    switch (wifiState) {
      case true:
        return "On";
      case false:
        return "Off";
      default:
        return "Off";
    }
  }


  Future<void> initPlatformState() async {
    String wifiState;
    wifiStatePlugin = WifiStatePlugin();

    try {
      bool? wifi_state = await wifiStatePlugin.getWifiState;
      wifiState = convertWifiState(wifi_state);

    } on PlatformException {
      wifiState = 'Failed to get wifi state.';
    }

    if (!mounted) return;

    setState(() {
      _wifiState = wifiState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Wifi state'),
          ),
          body: Center(
            child: StreamBuilder<bool>(
                stream: wifiStatePlugin.getWifiStateEvents,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  wifiStatePlugin.sendNotification("Wifi state",
                      "Changed to ${convertWifiState(snapshot.data)}");
                  return Text(
                    'Changed to: ${convertWifiState(snapshot.data)}\n',
                    style: TextStyle(fontSize: 25.0),
                  );
                }),
          )),
    );
  }
}
