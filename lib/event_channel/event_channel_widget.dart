import 'package:flutter/material.dart';
import 'package:test_project/event_channel/counter_method_channel.dart';

class EventChannelWidget extends StatefulWidget {
  const EventChannelWidget({super.key});

  @override
  State<EventChannelWidget> createState() => _EventChannelWidgetState();
}

class _EventChannelWidgetState extends State<EventChannelWidget> {
  late final CounterMethodChannel counterMethodChannel;

  @override
  void initState() {
    super.initState();
    counterMethodChannel = CounterMethodChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: counterMethodChannel.counterStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data.toString(),
                  ),
                );
              }

              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (counterMethodChannel.isRunning) {
                counterMethodChannel.stopCounter();
                return;
              }
              counterMethodChannel.startCounter();
            },
            child: const Text('Start Counter'),
          ),
        ],
      ),
    );
  }
}
