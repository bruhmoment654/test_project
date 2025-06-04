// ignore_for_file: constant_identifier_names

import 'package:flutter/services.dart';

class CounterMethodChannel {
  static const eventChannel = EventChannel('EVENT_CHANNEL_NAME');
  static const methodChannel = MethodChannel('METHOD_CHANNEL_NAME');

  bool isRunning = false;

  CounterMethodChannel() {
    counterStream = eventChannel.receiveBroadcastStream().map((data) {
      if (data is int) return data;

      return null;
    });
  }

  late final Stream<int?> counterStream;

  Future<void> startCounter() async {
    await methodChannel.invokeMethod('START_COUNTER');
    isRunning = true;
  }

  Future<void> stopCounter() async {
    await methodChannel.invokeMethod('STOP_COUNTER');
    isRunning = false;
  }
}

enum CounterKeys {
  STOP_COUNTER,
  START_COUNTER,
  EVENT_CHANNEL_NAME,
  METHOD_CHANNEL_NAME,
}
