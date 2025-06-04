import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelWidget extends StatefulWidget {
  @override
  State<MethodChannelWidget> createState() => _MethodChannelWidgetState();
}

class _MethodChannelWidgetState extends State<MethodChannelWidget> {
  static const platform = MethodChannel('test.flutter.io/battery');

  var _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    _getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_batteryLevel),
      ),
    );
  }
}
