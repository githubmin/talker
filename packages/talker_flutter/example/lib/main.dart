import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_example/extended_example/extended_example.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// You can see [ExtendedExample] to
/// check how logs working in realtime
///
///

void main() {
  final talker = TalkerFlutter.init();
  runZonedGuarded(
    () => runApp(BaseExample(talker: talker)),
    (Object error, StackTrace stack) {
      talker.handle(error, stack, 'Uncaught app exception');
    },
  );
}

class BaseExample extends StatefulWidget {
  const BaseExample({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  State<BaseExample> createState() => _BaseExampleState();
}

class _BaseExampleState extends State<BaseExample> {
  @override
  void initState() {
    final talker = widget.talker;
    talker.info('Renew token from expire date');
    _handleException();
    talker.warning('Cache images working slowly on this platform');
    talker.log('Server exception', logLevel: LogLevel.critical);
    talker.debug('Exception data sent for your analytics server');
    talker.verbose(
      'Start reloading config after critical server exception',
    );
    talker.info('3.............');
    talker.info('2.......');
    talker.info('1');
    talker.good('Now you can check all Talkler power ⚡');

    FlutterError.onError = (details) => talker.handle(
          details.exception,
          details.stack,
          'Uncaught Flutter exception',
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talker Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Talker Flutter')),
          body: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [Text('Track this Flutter problem. ' * 10)]),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TalkerScreen(talker: widget.talker),
                    ),
                  ),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Log Console'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _handleException() {
    try {
      throw Exception('Test service exception');
    } catch (e, st) {
      widget.talker.handle(e, st, 'FakeService exception');
    }
  }
}
