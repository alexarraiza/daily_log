import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:daily_log/ui/common/log_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LogEntryItem extends StatelessWidget {
  final LogEntryModel logEntry;
  final Function(LogEntryModel entry) onTap;

  const LogEntryItem(this.logEntry, {Key key, this.onTap})
      : assert(logEntry != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildFilledEntry(context);
  }

  ListTile _buildFilledEntry(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(logEntry.entry),
      ),
      trailing: (logEntry.tag != null) ? LogTag(tag: logEntry.tag) : null,
      onTap: () => onTap(logEntry),
    );
  }
}
