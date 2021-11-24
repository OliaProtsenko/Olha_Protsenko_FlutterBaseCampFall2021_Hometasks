import 'package:flutter/material.dart';
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
  String convertWifiState(int? wifiState){
    switch(wifiState){
      case 1: return "Off";
      case 3: return "On";
      default:return "Off";

    }
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String wifiState;
    wifiStatePlugin=WifiStatePlugin();
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      int? wifi_state=await wifiStatePlugin.getWifiState;
      wifiState=convertWifiState(wifi_state);
      // await WifiState.platformVersion ?? 'Unknown platform version';
    } on Exception {
      wifiState = 'Failed to get wifi state.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
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
            child: StreamBuilder<int>(
                stream: wifiStatePlugin.getWifiStateEvents,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text('Changed to: ${convertWifiState(snapshot.data)}\n',
                    style: TextStyle(fontSize: 25.0),);
                }),
          )

      ),
    );


  }
}
