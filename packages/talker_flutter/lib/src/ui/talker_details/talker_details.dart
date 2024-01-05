import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerDetails extends StatelessWidget {
  const TalkerDetails({
    Key? key,
    required this.data,
    this.onCopy,
  }) : super(key: key);

  final TalkerDataInterface data;
  final Function(TalkerDataInterface)? onCopy;

  static Route<TalkerDetails> route(
    TalkerDataInterface data, {
    Function(TalkerDataInterface)? onCopy,
  }) =>
      MaterialPageRoute(
        builder: (_) => TalkerDetails(data: data, onCopy: onCopy),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () => onCopy?.call(data),
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Text(data.generateTextMessage()),
        ),
      ),
    );
  }
}
