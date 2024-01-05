import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/src/ui/talker_details/talker_details.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorTypedLogsScreen extends StatefulWidget {
  const TalkerMonitorTypedLogsScreen({
    Key? key,
    required this.exceptions,
    required this.theme,
    required this.typeName,
  }) : super(key: key);

  final String typeName;
  final TalkerScreenTheme theme;
  final List<TalkerDataInterface> exceptions;

  @override
  State<TalkerMonitorTypedLogsScreen> createState() =>
      _TalkerMonitorTypedLogsScreenState();
}

class _TalkerMonitorTypedLogsScreenState
    extends State<TalkerMonitorTypedLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AppBar(
        title: Text('Talker Monitor ${widget.typeName}'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final data = widget.exceptions[index];
                return TalkerDataCard(
                  data: data,
                  onTap: () => Navigator.of(context).push(
                    TalkerDetails.route(
                      data,
                      onCopy: _copyTalkerDataItemText,
                    ),
                  ),
                );
              },
              childCount: widget.exceptions.length,
            ),
          ),
        ],
      ),
    );
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Log item is copied in clipboard');
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
